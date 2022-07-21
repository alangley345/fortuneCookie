import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})

export class FortuneService {

  constructor(private http: HttpClient) { }
  fortunes:any;
  readonly url = 'http://localhost:3000/api/fortunes/new';

  getNewFortune(){
    this.http.get<any>(this.url)
      .subscribe(data => {
        this.fortunes = data;
      });
    return this.fortunes
  }
}
