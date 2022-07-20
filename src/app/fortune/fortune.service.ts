import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError, retry } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})

export class FortuneService {

  constructor(private http: HttpClient) { }

  private url = 'localhost:3000/api/fortunes/new';

  getFortune(){
    return this.http.get(this.url);
  } 
}
