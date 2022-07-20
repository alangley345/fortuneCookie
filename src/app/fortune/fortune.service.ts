import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})

export class FortuneService {

  constructor(private http: HttpClient) { }

  private url = 'http://localhost:3000/api/fortunes/new';

  getFortune(){
    return this.http.get(this.url);
  } 
}
