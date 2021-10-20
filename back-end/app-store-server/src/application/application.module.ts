import { Module } from '@nestjs/common';
import { ApplicationService } from './application.service';
import { ApplicationController } from './application.controller';

@Module({
  providers: [ApplicationService],
  controllers: [ApplicationController]
})
export class ApplicationModule {}
