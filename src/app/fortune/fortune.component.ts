import { Component, OnInit } from '@angular/core';
import { response } from 'express';
import { FortuneService } from './fortune.service';

@Component({
  selector: 'app-fortune',
  templateUrl: './fortune.component.html',
  styleUrls: ['./fortune.component.scss'],
  providers: [ FortuneService ]
})

export class FortuneComponent implements OnInit {

  constructor(private fortuneservice: FortuneService) {}
  fortunes:any;

  showNewFortune(){
    this.fortuneservice.getNewFortune()
      .fortunes((data: any) => {
        this.fortunes = data;
      });
  }

  ngOnInit(){
   this.showNewFortune();
  }
}
