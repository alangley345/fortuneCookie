import { TestBed } from '@angular/core/testing';

import { FortuneService } from './fortune.service';

describe('FortuneService', () => {
  let service: FortuneService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(FortuneService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
