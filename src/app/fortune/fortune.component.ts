import { Component, OnInit } from '@angular/core';
import { Inject } from '@angular/core';
import { FortuneService } from './fortune.service';
//import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-fortune',
  templateUrl: './fortune.component.html',
  styleUrls: ['./fortune.component.scss'],
  providers: [ FortuneService ]
})

export class FortuneComponent implements OnInit {

  constructor(@Inject(FortuneService) private fortuneservice: FortuneService){}
  fortunes:any;
  
  //calls gets new fortune from DB
  showNewFortune(){
    this.fortuneservice.getNewFortune()
      .subscribe((data: any) => this.fortunes = data);
  }

  //addNewFortune(){
  //  this.fortuneservice.addNewFortune();
  //}
  
  ngOnInit(){
    this.showNewFortune();
  }
}
