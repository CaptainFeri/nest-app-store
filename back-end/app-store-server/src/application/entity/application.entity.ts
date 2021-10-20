import { Column, Entity } from 'typeorm';

@Entity({ name: 'applications' })
export class ApplicationEntity {
  @Column()
  id: number;
  @Column()
  track_name: string;
  @Column()
  size_bytes: string;
  @Column()
  currency: string;
  @Column()
  price: string;
  @Column()
  rating_count_tot: string;
  @Column()
  rating_count_ver: string;
  @Column()
  user_rating: string;
  @Column()
  ver: string;
  @Column()
  cont_rating: string;
  @Column()
  prime_genre: string;
  @Column()
  sup_devicesnum: number;
  @Column()
  ipadSc_urlsnum: number;
  @Column()
  langnum: number;
  @Column()
  vpp_lic: number;
}
