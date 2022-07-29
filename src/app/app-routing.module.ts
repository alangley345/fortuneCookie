import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { FortuneComponent } from './fortune/fortune.component';
import { AccountComponent } from './account/account.component';
import { ContributeComponent } from './contribute/contribute.component';

const routes: Routes = [
  { path: '', redirectTo: 'fortune'},
  { path: 'fortune', component: FortuneComponent },
  { path: 'account', component: AccountComponent },
  { path: 'contribute', component: ContributeComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
