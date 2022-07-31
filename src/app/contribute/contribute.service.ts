import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class ContributeService {

  constructor(private http: HttpClient) { }
  readonly apiURL = 'http://localhost:3000/api/fortunes/';

  addNewFortune(){
    return this.http.post<any>(this.apiURL+'add',);
  }
}
