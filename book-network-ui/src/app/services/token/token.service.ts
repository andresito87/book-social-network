import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class TokenService {

  set token(token: string) {
    localStorage.setItem('token', token);
  }

  get token(): string {
    try {
      return localStorage.getItem('token') as string;
    } catch (e) {
      return '';
    }
  }
}
