package com.andres.book.feedback;

import com.andres.book.book.Book;
import com.andres.book.book.BookRepository;
import com.andres.book.common.PageResponse;
import com.andres.book.exception.OperationNotPermittedException;
import com.andres.book.user.User;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class FeedbackService {

    private final BookRepository bookRepository;
    private final FeedbackMapper feedbackMapper;
    private final FeedbackRepository feedbackRepository;

    public Integer save(FeedbackRequest request, Authentication connectedUser) {

        Book book = bookRepository.findById(request.bookId())
                .orElseThrow(() -> new EntityNotFoundException("Book with ID " + request.bookId() + " not found"));
        if (book.isArchived() || !book.isShareable()) {
            throw new OperationNotPermittedException("You cannot give feedback on an archived or non-shareable book");
        }
        User user = (User) connectedUser.getPrincipal();
        if (book.getOwner().getId().equals(user.getId())) {
            throw new OperationNotPermittedException("You cannot give feedback on your own book");
        }
        Feedback feedback = feedbackMapper.toFeedback(request, user, book);

        return feedbackRepository.save(feedback).getId();

    }

    public PageResponse<FeedbackResponse> findAllFeedbacksByBook(Integer bookId, int page, int size, Authentication connectedUser) {

        Pageable pageable = PageRequest.of(page, size);
        User user = (User) connectedUser.getPrincipal();
        Page<Feedback> feedbacks = feedbackRepository.findAllByBookId(bookId, pageable);
        List<FeedbackResponse> feedbackResponses = feedbacks.stream()
                .map(feedback -> feedbackMapper.toFeedbackResponse(feedback, user.getId()))
                .toList();

        return new PageResponse<>(
                feedbackResponses,
                feedbacks.getNumber(),
                feedbacks.getSize(),
                feedbacks.getTotalElements(),
                feedbacks.getTotalPages(),
                feedbacks.isFirst(),
                feedbacks.isLast()
        );
    }
}
