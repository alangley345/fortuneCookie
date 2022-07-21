import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HttpClientModule} from '@angular/common/http';
import { FortuneComponent } from './fortune/fortune.component';
import { FortuneService } from './fortune/fortune.service';

@NgModule({
  declarations: [
    AppComponent,
    FortuneComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    AppRoutingModule
  ],
  providers: [FortuneService],
  bootstrap: [AppComponent]
})
export class AppModule { }
