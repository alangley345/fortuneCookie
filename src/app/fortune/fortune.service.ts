import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})

export class FortuneService {

  constructor(private http: HttpClient) { }
  readonly url = 'http://localhost:3000/api/fortunes/new';

  getNewFortune(){
    return this.http.get<any>(this.url);
  }
}
