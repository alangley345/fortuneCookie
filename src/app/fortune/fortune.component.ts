import { Component, OnInit } from '@angular/core';
import { FortuneService } from './fortune.service';

@Component({
  selector: 'app-fortune',
  templateUrl: './fortune.component.html',
  styleUrls: ['./fortune.component.scss']
})

export class FortuneComponent implements OnInit {

  fortune:any;

  constructor(private service: FortuneService) { }

  ngOnInit(){
    this.service.getFortune()
      .subscribe(response => {
        this.fortune = response;
    });
  }
}
