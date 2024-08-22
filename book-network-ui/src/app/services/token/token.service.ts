import { Injectable } from '@angular/core';
import {jwtDecode} from 'jwt-decode';

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

  get isTokenValid(): boolean {
    const token = this.token;

    try {
      // Si usas la librería jwt-decode
      const decodedToken = jwtDecode(token);

      // Comprueba si el token tiene un campo 'exp' (fecha de expiración)
      if (decodedToken.exp) {
        const currentTime = Math.floor(Date.now() / 1000);
        return decodedToken.exp > currentTime;
      }

      return false;
    } catch (error) {
      console.error('Token no válido o malformado', error);
      return false;
    }
  }
}
