/* tslint:disable */
/* eslint-disable */
import { NgModule, ModuleWithProviders, SkipSelf, Optional } from '@angular/core';
import {HTTP_INTERCEPTORS, HttpClient, HttpClientModule} from '@angular/common/http';
import { ApiConfiguration, ApiConfigurationParams } from './api-configuration';

import { FeedbackService } from './services/feedback.service';
import { BookService } from './services/book.service';
import { AuthenticationService } from './services/authentication.service';
import {HttpTokenInterceptor} from "./interceptor/http-token.interceptor";

/**
 * Module that provides all services and configuration.
 */
@NgModule({
  imports: [
    HttpClientModule
  ],
  exports: [],
  declarations: [],
  providers: [
    FeedbackService,
    BookService,
    AuthenticationService,
    ApiConfiguration,
    HttpClient,
    {
      provide: HTTP_INTERCEPTORS,
      useFactory: HttpTokenInterceptor,
      multi: true
    }
  ],
})
export class ApiModule {
  static forRoot(params: ApiConfigurationParams): ModuleWithProviders<ApiModule> {
    return {
      ngModule: ApiModule,
      providers: [
        {
          provide: ApiConfiguration,
          useValue: params
        }
      ]
    }
  }

  constructor(
    @Optional() @SkipSelf() parentModule: ApiModule,
    @Optional() http: HttpClient
  ) {
    if (parentModule) {
      throw new Error('ApiModule is already loaded. Import in your base AppModule only.');
    }
    if (!http) {
      throw new Error('You need to import the HttpClientModule in your AppModule! \n' +
      'See also https://github.com/angular/angular/issues/20575');
    }
  }
}
