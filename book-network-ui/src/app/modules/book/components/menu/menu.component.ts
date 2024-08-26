import {Component, inject, OnInit} from '@angular/core';
import {RouterLink} from "@angular/router";
import {TokenService} from "../../../../services/token/token.service";
import {jwtDecode} from "jwt-decode";

@Component({
  selector: 'app-menu',
  standalone: true,
  imports: [
    RouterLink
  ],
  templateUrl: './menu.component.html',
  styleUrl: './menu.component.scss'
})
export class MenuComponent implements OnInit {
  token = inject(TokenService).token;
  fullName: string = '';

  ngOnInit(): void {
    if (typeof document !== 'undefined') {
      const linkColor = document.querySelectorAll('.nav-link');
      linkColor.forEach(link => {
        if (window.location.href.endsWith(link.getAttribute('href') || '')) {
          link.classList.add('active');
        }
        link.addEventListener('click', () => {
          linkColor.forEach(l => l.classList.remove('active'));
          link.classList.add('active');
        });
      });
      // obtener el nombre del usuario
      ({fullName: this.fullName} = jwtDecode(this.token));
    }
  }

  logout() {
    localStorage.removeItem('token');
    window.location.reload();
  }
}
