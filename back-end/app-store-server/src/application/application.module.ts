import { Module } from '@nestjs/common';
import { ApplicationService } from './application.service';
import { ApplicationController } from './application.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ApplicationEntity } from './entity/application.entity';
import { ApplicationDesEntity } from './entity/applicationDes.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([ApplicationEntity, ApplicationDesEntity]),
  ],
  providers: [ApplicationService],
  controllers: [ApplicationController],
})
export class ApplicationModule {}
