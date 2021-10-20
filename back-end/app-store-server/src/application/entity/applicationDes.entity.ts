import { Column, Entity } from 'typeorm';

@Entity({ name: 'app-des' })
export class ApplicationDesEntity {
  @Column()
  id: number;
  @Column()
  track_name: string;
  @Column()
  size_bytes: string;
  @Column()
  app_desc: string;
}
