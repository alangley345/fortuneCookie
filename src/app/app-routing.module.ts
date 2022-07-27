import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { FortuneComponent } from 'app/fortune/fortune.component';
import { AccountComponent } from 'app/account/account.component';

const routes: Routes = [
  { path: '/', redirectTo: 'fortune'},
  { path: 'fortune', component: FortuneComponent },
  { path: 'account', component: AccountComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
