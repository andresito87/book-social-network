import {HttpHeaders, HttpInterceptorFn} from '@angular/common/http';
import {inject} from "@angular/core";
import {TokenService} from '../token/token.service';

export const HttpTokenInterceptor: HttpInterceptorFn = (request, next) => {
  const token = inject(TokenService).token;
  const tokenValid = inject(TokenService).isTokenValid;
  if (token) {
    if (tokenValid) {
      const authReq = request.clone({
        headers: new HttpHeaders({
          Authorization: 'Bearer ' + token
        })
      });
      return next(authReq);
    }
  }
  return next(request);
};
