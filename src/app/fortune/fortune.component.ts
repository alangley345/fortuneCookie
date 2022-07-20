import { Component, OnInit } from '@angular/core';
import { FortuneService } from './fortune.service';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-fortune',
  templateUrl: './fortune.component.html',
  styleUrls: ['./fortune.component.scss']
})

export class FortuneComponent implements OnInit {

  constructor(private http: HttpClient) { }

  readonly url = 'http://localhost:3000/api/fortunes/new';
  fortunes:any;

  ngOnInit(){
     this.http.get<any>('http://localhost:3000/api/fortunes/new')
      .subscribe(data => {
        this.fortunes = data;
      }); 
  }
}
