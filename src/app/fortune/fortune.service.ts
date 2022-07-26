import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})

export class FortuneService {

  constructor(private http: HttpClient) { }
  readonly apiURL = 'http://localhost:3000/api/fortunes/';

  getNewFortune(){
    return this.http.get<any>(this.apiURL+'new');
  }

  //addNewFortune(){
  //  return this.http.post<any>(this.apiURL+'add',);
  //}
}
