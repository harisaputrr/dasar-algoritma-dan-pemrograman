Program RukunTangga;
{I.S : Menerima inputan user dalam aplikasi Rukun Tangga pada Emerald City.
 F.S : Menampilkan menu - menu dalam program Rukun Tangga pada Emerald City}
uses crt,sysutils;
Const max=1000;
Type
	FamilyRecord =
	record
		kepkel : string;
		jumkel,jumdis : integer;
		nokk,jumpen,jumblt : longint;
	end;
Type Keluarga = array [1..max] of FamilyRecord;

Var
	fileklr: file of Keluarga;
	jumklr: file of integer;
	fmr: Keluarga;
	jumdat,n: integer;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Procedure HitungBLT(kel,dis:integer; pend:longint; var cek:boolean; var blt:longint);
{I.S : Mengambil jumlah keluarga, disabilitas, pendapatan. Lalu menghitung BLT dari data yang didapat.
 F.S : Mengembalikan hasil dari BLT yang sudah di hitung dan cek mendapatkan BLT atau tidak. }
var
	minbulan,uangblt:longint;
	bulanan:longint;
begin
	minbulan:=500000;
	uangblt:=450000;
	bulanan:=pend div kel;
	if (bulanan < minbulan) and (dis <= 3) then 
		begin
			blt:=uangblt*dis;
			cek:=true;
		end
	else if (bulanan < minbulan) and (dis > 3) then begin
		blt:=uangblt*3;
		cek:=true;
	end
	else
		cek:=false;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Procedure LihatBLT(blt:boolean; jumblt:longint; var tambah:string);
{I.S : Mendapatkan cek BLT dan jumlah BLT. Dan menginputkan tambah data.
 F.S : Menampilkan mendapat BLT atau tidak. Mengembalikan pilihan untuk menambahkan data lagi atau tidak.}
begin
	clrscr;
	writeln('================[ EMERALD CITY DATABASE ]================');
	writeln('=                                                       =');
	writeln('===========[ HOME > TAMBAH DATA > HASIL DATA ]===========');
	writeln;
	writeln;
	if (blt = true) then begin
		writeln('             Anda Mendapatkan BLT Sebesar ',jumblt);
	end	
	else if (blt = false) then begin
		writeln('              Anda tidak mendapatkan BLT');
	end;
	{end if}
	writeln;
	writeln;
	writeln('=========================================================');
	write  ('Tekan Enter Untuk Melanjutkan . . .');readln;
	clrscr;
	repeat
		write('Apakah Anda ingin menambahkan data lagi ? (Y/N) : ');readln(tambah);
	until(upcase(tambah) = 'Y') or (upcase(tambah) = 'N');
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
Procedure TambahData(var fmr:Keluarga; var jumdat:integer);
{I.S : Terdefinisi Jumlah data. User menginputkan data - data dengan No. KK yang belum terdaftar sebelumnya. 
 F.S : Mengembalikan Jumlah data.}
var
	pil,pilplus: string;
	cekblt,dup: boolean;
	nokk,i:integer;
begin
	repeat
		i:=1;dup:=false;
		clrscr;
		//writeln('Jumlah data',jumdat);
		writeln('================[ EMERALD CITY DATABASE ]================');
		writeln('=                                                       =');
		writeln('=================[ HOME > TAMBAH DATA ]==================');
		writeln;
		write  ('     Nomor Kartu Keluarga : ');readln(nokk);
		while (i<=jumdat) do begin
			if (nokk = fmr[i].nokk) then begin
				writeln;
				writeln('=========================================================');
				writeln;
				writeln('            No Kartu Keluarga Sudah Terdaftar');
				writeln;
				writeln('=========================================================');
				write  ('Tekan Enter Untuk Melanjutkan . . .');readln;
				dup:=true;
			end;
			i:=i+1;
		end;
		if (dup=true) then begin
			pilplus:='N';
		end
		else if (dup=false) then begin
			n:=jumdat+1;
			fmr[n].nokk:=nokk;
			write  ('     Nama Kepala Keluarga : ');readln(fmr[n].kepkel);
			write  ('     Jumlah Anggota Keluarga : ');readln(fmr[n].jumkel);
			write  ('     Jumlah Pendapatan : ');readln(fmr[n].jumpen);
			write  ('     Jumlah Penyandang Disabilitas : ');readln(fmr[n].jumdis);
			writeln;
			writeln('=========================================================');
			writeln('  1. Tambah');
			writeln('  2. Kembali');
			writeln('=========================================================');
			write  ('  Masukkan pilihan anda : ');readln(pil);
			case pil of
				'1':begin
					HitungBLT(fmr[n].jumkel,fmr[n].jumdis,fmr[n].jumpen,cekblt,fmr[n].jumblt);
					LihatBLT(cekblt,fmr[n].jumblt,pilplus);
					jumdat:=n;
				end;
				'2':begin
					pilplus:='N';
				end;
			end;
		end;
	until(upcase(pilplus) = 'N');
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Procedure HapusData(var fmr:Keluarga;var jumdat:integer);
{I.S : Terdefinisi Jumlah Data. User menginputkan No. KK dari data yang akan di hapus.
 F.S : Menampilkan tampilan bahwa data terhapus atau tidak.}
var
	cari:integer;
	pilhapus:string;
	fnd:boolean;
begin
	clrscr;
	writeln('=======================[ Emerald City Database ]=======================');
	writeln('=                                                                     =');
	writeln('=========================[ HOME > HAPUS DATA ]=========================');
	writeln;
	write  ('  Masukkan Nomor Kartu Keluarga dari data yang akan di hapus : ');readln(cari);
	n:=1;
	fnd:=false;
	while (n <= jumdat) do begin
		if (cari = fmr[n].nokk) then begin
			fnd:=true;
			clrscr;
			writeln('================[ Emerald City Database ]================');
			writeln('=                                                       =');
			writeln('==================[ HOME > HAPUS DATA ]==================');
			writeln;
			writeln;
			writeln('     Nomor Kartu Keluarga : ',fmr[n].nokk);
			writeln('     Nama Kepala Keluarga : ',fmr[n].kepkel);
			writeln('     Jumlah Anggota Keluarga : ',fmr[n].jumkel);
			writeln('     Jumlah Pendapatan : ',fmr[n].jumpen);
			writeln('     Jumlah Penyandang Disabilitas : ',fmr[n].jumdis);
			writeln('     Jumlah Bantuan Langsung Tunai : ',fmr[n].jumblt);
			writeln;
			writeln;
			writeln('=========================================================');
			repeat
				write  ('  Apakah anda ingin hapus data ini ? (Y/N) : ');readln(pilhapus);
			until(upcase(pilhapus) = 'Y') or (upcase(pilhapus) = 'N');
			if (upcase(pilhapus) = 'Y') then begin
				writeln('=========================================================');
				writeln;
				writeln('                     Hapus Berhasil!');
				writeln;
				writeln('=========================================================');
				write  ('Tekan Enter Untuk Melanjutkan . . .');readln;
				while (n <= jumdat-1) do begin
					fmr[n]:=fmr[n+1];
					n:=n+1;
				end;
				jumdat:=jumdat-1;
			end;
		end;
		n:=n+1;
	end;
	if (n > jumdat) and (fnd = false) then begin
		clrscr;
		writeln('================[ Emerald City Database ]================');
		writeln('=                                                       =');
		writeln('==================[ HOME > HAPUS DATA ]==================');
		writeln;
		writeln('                  Data tidak ditemukan!');
		writeln;
		writeln('=========================================================');
		write  ('Tekan Enter Untuk Melanjutkan . . .');readln;
	end;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Procedure SrchNokk (var fmr:Keluarga; jumdat:integer);
{I.S : Terdefinisi Jumlah data. User Menginputkan No. KK yang ingin dicari.
 F.S : Menampilkan bahwa data ada atau tidak.}
var
	cari,i:integer;
	carilagi:string;
begin
	repeat
	clrscr;
	writeln('================[ Emerald City Database ]================');
	writeln('=                                                       =');
	writeln('==================[ HOME > CARI DATA ]===================');
	writeln;
	write  ('  Masukkan Nomor Kartu Keluarga yang ingin di cari : ');readln(cari);
	i:=0;
	while (i < jumdat) and (cari <> fmr[i].nokk) do begin
		i:=i+1;
		if (cari = fmr[i].nokk) then begin
			clrscr;
			writeln('================[ Emerald City Database ]================');
			writeln('=                                                       =');
			writeln('==================[ HOME > CARI DATA ]===================');
			writeln;
			writeln('                     Data ditemukan!');
			writeln;
			writeln('=========================================================');
			write  ('Tekan Enter Untuk Melanjutkan . . .');readln;
			clrscr;
			writeln('================[ Emerald City Database ]================');
			writeln('=                                                       =');
			writeln('==================[ HOME > CARI DATA ]===================');
			writeln;
			writeln;
			writeln('     Nomor Kartu Keluarga : ',fmr[i].nokk);
			writeln('     Nama Kepala Keluarga : ',fmr[i].kepkel);
			writeln('     Jumlah Anggota Keluarga : ',fmr[i].jumkel);
			writeln('     Jumlah Pendapatan : ',fmr[i].jumpen);
			writeln('     Jumlah Penyandang Disabilitas : ',fmr[i].jumdis);
			writeln('     Jumlah Bantuan Langsung Tunai : ',fmr[i].jumblt);
			writeln;
			writeln;
			writeln('=========================================================');
			write  ('Tekan Enter Untuk Melanjutkan . . .');readln;
		end;
	end;
	if (cari <> fmr[i].nokk) then begin
		clrscr;
		writeln('================[ Emerald City Database ]================');
		writeln('=                                                       =');
		writeln('==================[ HOME > CARI DATA ]===================');
		writeln;
		writeln('                     Data tidak ditemukan!');
		writeln;
		writeln('=========================================================');
		write  ('Tekan Enter Untuk Melanjutkan . . .');readln;
	end;
	repeat
		clrscr;
		write('Apakah Anda ingin mencari data lagi ? (Y/N) : ');readln(carilagi);
	until(upcase(carilagi) = 'Y') or (upcase(carilagi) = 'N');
	until(upcase(carilagi) = 'N')
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Procedure SrchKepkel (var fmr:Keluarga; jumdat:integer);
{I.S : Terdefinisi Jumlah data. User Menginputkan No. KK yang ingin dicari.
 F.S : Menampilkan bahwa data ditemukan atau tidak.}
var
	i:integer;
	cari,carilagi:string;
begin
	repeat
	clrscr;
	writeln('================[ Emerald City Database ]================');
	writeln('=                                                       =');
	writeln('==================[ HOME > CARI DATA ]===================');
	writeln;
	write  ('  Masukkan Kepala Keluarga yang ingin di cari : ');readln(cari);
	i:=0;
	while (i < jumdat) and (cari <> fmr[i].kepkel) do begin
		i:=i+1;
		if (cari = fmr[i].kepkel) then begin
			clrscr;
			writeln('================[ Emerald City Database ]================');
			writeln('=                                                       =');
			writeln('==================[ HOME > CARI DATA ]===================');
			writeln;
			writeln('                     Data ditemukan!');
			writeln;
			writeln('=========================================================');
			write  ('Tekan Enter Untuk Melanjutkan . . .');readln;
			clrscr;
			writeln('================[ Emerald City Database ]================');
			writeln('=                                                       =');
			writeln('==================[ HOME > CARI DATA ]===================');
			writeln;
			writeln;
			writeln('     Nomor Kartu Keluarga : ',fmr[i].nokk);
			writeln('     Nama Kepala Keluarga : ',fmr[i].kepkel);
			writeln('     Jumlah Anggota Keluarga : ',fmr[i].jumkel);
			writeln('     Jumlah Pendapatan : ',fmr[i].jumpen);
			writeln('     Jumlah Penyandang Disabilitas : ',fmr[i].jumdis);
			writeln('     Jumlah Bantuan Langsung Tunai : ',fmr[i].jumblt);
			writeln;
			writeln;
			writeln('=========================================================');
			write  ('Tekan Enter Untuk Melanjutkan . . .');readln;
		end;
	end;
	if (cari <> fmr[i].kepkel) then begin
		clrscr;
		writeln('================[ Emerald City Database ]================');
		writeln('=                                                       =');
		writeln('==================[ HOME > CARI DATA ]===================');
		writeln;
		writeln('                     Data tidak ditemukan!');
		writeln;
		writeln('=========================================================');
		write  ('Tekan Enter Untuk Melanjutkan . . .');readln;
	end;
	repeat
		clrscr;
		write('Apakah Anda ingin mencari data lagi ? (Y/N) : ');readln(carilagi);
	until(upcase(carilagi) = 'Y') or (upcase(carilagi) = 'N');
	until(upcase(carilagi) = 'N')
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Procedure EditMethod(var fmr:Keluarga; n:integer;mtd:string);
{I.S : Terdefinisi jumlah data dan Metode edit.
 F.S : Memunculkan tampilan Data sebelum dan sesudah di edit.}
begin
	if (mtd = '1') then begin
		clrscr;
		writeln('================[ Emerald City Database ]================');
		writeln('=                                                       =');
		writeln('=======[ HOME > EDIT DATA > EDIT KEPALA KELUARGA ]=======');
		writeln;
		writeln('               Kepala Keluarga sebelum di edit : ');
		writeln('               ',fmr[n].kepkel);
		writeln;
		writeln('              ==================================');
		writeln;
		writeln('               Kepala Keluarga sesudah di edit : ');
		write  ('               ');readln(fmr[n].kepkel);
		writeln;
		writeln('=========================================================');
		writeln;
		writeln('                      Edit Berhasil!');
		writeln;
		writeln('=========================================================');
		readln;
	end
	else if (mtd = '2') then begin
		clrscr;
		writeln('================[ Emerald City Database ]================');
		writeln('=                                                       =');
		writeln('===========[ HOME > EDIT DATA > EDIT KELUARGA ]==========');
		writeln;
		writeln('               Jumlah Keluarga sebelum di edit : ');
		writeln('               ',fmr[n].jumkel);
		writeln;
		writeln('              ==================================');
		writeln;
		writeln('               Jumlah Keluarga sesudah di edit : ');
		write  ('               ');readln(fmr[n].jumkel);
		writeln;
		writeln('=========================================================');
		writeln;
		writeln('                      Edit Berhasil!');
		writeln;
		writeln('=========================================================');
		readln;
	end
	else if (mtd = '3') then begin
		clrscr;
		writeln('================[ Emerald City Database ]================');
		writeln('=                                                       =');
		writeln('==========[ HOME > EDIT DATA > EDIT PENDAPATAN ]=========');
		writeln;
		writeln('               Pendapatan sebelum di edit :');
		writeln('               ',fmr[n].jumpen);
		writeln;
		writeln('              =============================');
		writeln;
		writeln('               Pendapatan sesudah di edit :');
		write  ('               ');readln(fmr[n].jumpen);
		writeln;
		writeln('=========================================================');
		writeln;
		writeln('                      Edit Berhasil!');
		writeln;
		writeln('=========================================================');
		readln;
	end
	else if (mtd = '4') then begin
		clrscr;
		writeln('================[ Emerald City Database ]================');
		writeln('=                                                       =');
		writeln('=========[ HOME > EDIT DATA > EDIT DISABILITAS ]=========');
		writeln;
		writeln('               Disabilitas sebelum di edit :');
		writeln('               ',fmr[n].jumdis);
		writeln;
		writeln('              ==============================');
		writeln;
		writeln('               Disabilitas sesudah di edit :');
		write  ('               ');readln(fmr[n].jumdis);
		writeln;
		writeln('=========================================================');
		writeln;
		writeln('                      Edit Berhasil!');
		writeln;
		writeln('=========================================================');
		readln;
	end;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Procedure EditData(var fmr:Keluarga; jumdat:integer);
{I.S : Terdefinisi jumlah data. User menginputkan No. KK dari data yang akan di edit.
 F.S : Menampilka Data yang akan di edit jika ditemukkan. User memilih data yang akan di edit.}
var
	piledit,pil:string;
	cari:integer;
	fnd,cekblt:boolean;
begin
	clrscr;
	writeln('=======================[ Emerald City Database ]=======================');
	writeln('=                                                                     =');
	writeln('=========================[ HOME > HAPUS DATA ]=========================');
	writeln;
	write  ('  Masukkan Nomor Kartu Keluarga dari data yang akan di edit : ');readln(cari);
	n:=1;
	fnd:=false;	
	while (n <= jumdat) do begin
		if (cari = fmr[n].nokk) then begin
			fnd:=true;
			clrscr;
			writeln('================[ Emerald City Database ]================');
			writeln('=                                                       =');
			writeln('===================[ HOME > EDIT DATA ]==================');
			writeln;
			writeln;
			writeln('      Nomor Kartu Keluarga : ',fmr[n].nokk);
			writeln('      Nama Kepala Keluarga : ',fmr[n].kepkel);
			writeln('      Jumlah Anggota Keluarga : ',fmr[n].jumkel);
			writeln('      Jumlah Pendapatan : ',fmr[n].jumpen);
			writeln('      Jumlah Penyandang Disabilitas : ',fmr[n].jumdis);
			writeln('      Jumlah Bantuan Langsung Tunai : ',fmr[n].jumblt);
			writeln;
			writeln;
			writeln('=========================================================');
			repeat
				write  ('  Apakah anda ingin hapus data ini ? (Y/N) : ');readln(piledit);
			until(upcase(piledit) = 'Y') or (upcase(piledit) = 'N');
			if (upcase(piledit) = 'Y') then begin
				repeat
					clrscr;
					writeln('================[ Emerald City Database ]================');
					writeln('=                                                       =');
					writeln('===================[ HOME > EDIT DATA ]==================');
					writeln;
					writeln;
					writeln('     1. Kepala Keluarga     4. Penyandang Disabilitas');
					writeln('     2. Anggota Keluarga    5. Kembali');
					writeln('     3. Pendapatan');
					writeln;
					writeln;
					writeln('=========================================================');
					write  ('  Masukkan data yang akan di edit : ');readln(pil);
					case pil of
						'1':begin
							EditMethod(fmr,n,pil);
						end;
						'2':begin
							EditMethod(fmr,n,pil);
						end;
						'3':begin
							EditMethod(fmr,n,pil);
						end;
						'4':begin
							EditMethod(fmr,n,pil);
						end;
						'5':begin
							EditMethod(fmr,n,pil);
						end;
					end;
				until(pil = '6');
				HitungBLT(fmr[n].jumkel,fmr[n].jumdis,fmr[n].jumpen,cekblt,fmr[n].jumblt);
			end;
		end;
		n:=n+1;
	end;
	if (n > jumdat) and (fnd = false) then begin
		clrscr;
		writeln('================[ Emerald City Database ]================');
		writeln('=                                                       =');
		writeln('==================[ HOME > HAPUS DATA ]==================');
		writeln;
		writeln('                  Data tidak ditemukan!');
		writeln;
		writeln('=========================================================');
		write  ('Tekan Enter Untuk Melanjutkan . . .');readln;
	end;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Procedure LihatData(var fmr:Keluarga; jumdat:integer);
{I.S : Terdefinisi jumlah data.
 F.S : Memunculkan data sampai jumlah data yang ada.}
var
	nav:string;
begin
	n:=1;
	repeat
		clrscr;
		writeln('================[ Emerald City Database ]================');
		writeln('=                                                       =');
		writeln('============[ HOME > LIHAT DATA > HALAMAN ',n,' ]============');
		writeln;
		writeln('      Nomor Kartu Keluarga : ',fmr[n].nokk);
		writeln('      Nama Kepala Keluarga : ',fmr[n].kepkel);
		writeln('      Jumlah Anggota Keluarga : ',fmr[n].jumkel);
		writeln('      Jumlah Pendapatan : ',fmr[n].jumpen);
		writeln('      Jumlah Penyandang Disabilitas : ',fmr[n].jumdis);
		writeln('      Jumlah Bantuan Langsung Tunai : ',fmr[n].jumblt);
		writeln;
		writeln('=========================================================');
		writeln('  1. Selanjutnya');
		writeln('  2. Sebelumnya ');
		writeln('  3. Kembali');
		writeln('=========================================================');
		write  ('  Masukkan pilihan anda : ');readln(nav);
		case nav of
			'1':begin
				n:=n+1;
			end;
			'2':begin
				n:=n-1;
			end
		end;
		if(n = 0) or (n > jumdat) then begin
			clrscr;
			writeln('================[ Emerald City Database ]================');
			writeln('                                                         ');
			writeln('                                                         ');
			writeln('                Sudah Sampai Data Terakhir               ');
			writeln('                                                         ');
			writeln('                                                         ');
			writeln('=========================================================');
			readln;
			if (n > jumdat) then
				n:=jumdat
			else if (n = 0) then
				n:=1;
			{end if}
		end;
	until(nav = '3');
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Procedure SortNokk(var fmr:Keluarga; jumdat:integer;mtd:string);
{I.S : Terdifinisi jumlah data dan metode pengurutannya.
 F.S : - }
var
	temp:FamilyRecord;
	i,j:integer;
begin
	for i:=jumdat downto 2 do begin
		for j:=2 to i do begin
			if (mtd = '1') then begin
				if (fmr[j-1].nokk > fmr[j].nokk) then begin
					temp:= fmr[j-1];
					fmr[j-1]:= fmr[j];
					fmr[j]:= temp;
				end;
			end
			else if (mtd = '2') then begin
				if (fmr[j-1].nokk < fmr[j].nokk) then begin
					temp:= fmr[j-1];
					fmr[j-1]:= fmr[j];
					fmr[j]:= temp;
				end;
			end;
		end;
	end;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Procedure SortKepkel(var fmr:Keluarga; jumdat:integer;mtd:string);
{I.S : Terdifinisi jumlah data dan metode pengurutannya.
 F.S : - }
var
	temp:FamilyRecord;
	kepkel1,kepkel2:string;
	i,j:integer;
begin
	
	for i:=jumdat downto 2 do begin
		for j:=2 to i do begin
			kepkel1:=upcase(fmr[j-1].kepkel[1]);
			kepkel2:=upcase(fmr[j].kepkel);
			if (mtd = '1') then begin
				if (kepkel1 > kepkel2) then begin
					temp:= fmr[j-1];
					fmr[j-1]:= fmr[j];
					fmr[j]:= temp;
				end;
			end
			else if (mtd = '2') then begin
				if (kepkel1 < kepkel2) then begin
					temp:= fmr[j-1];
					fmr[j-1]:= fmr[j];
					fmr[j]:= temp;
				end;
			end;
		end;
	end;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Procedure SortJumkel(var fmr:Keluarga; jumdat:integer;mtd:string);
{I.S : Terdifinisi jumlah data dan metode pengurutannya.
 F.S : - }
var
	temp:FamilyRecord;
	i,j:integer;
begin
	for i:=jumdat downto 2 do begin
		for j:=2 to i do begin
			if (mtd = '1') then begin
				if (fmr[j-1].jumkel > fmr[j].jumkel) then begin
					temp:= fmr[j-1];
					fmr[j-1]:= fmr[j];
					fmr[j]:= temp;
				end;
			end
			else if (mtd = '2') then begin
				if (fmr[j-1].jumkel < fmr[j].jumkel) then begin
					temp:= fmr[j-1];
					fmr[j-1]:= fmr[j];
					fmr[j]:= temp;
				end;
			end;
		end;
	end;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Procedure SortJumpen(var fmr:Keluarga; jumdat:integer;mtd:string);
{I.S : Terdifinisi jumlah data dan metode pengurutannya.
 F.S : - }
var
	i,j:integer;
	temp:FamilyRecord;
begin
	for i:=1 to jumdat-1 do begin
		j:=i+1;
		temp:=fmr[j];
		if (mtd = '1') then begin
			while ((j > 1) and (temp.jumpen < fmr[j-1].jumpen)) do begin
				fmr[j]:=fmr[j-1];
				j:=j-1;
			end;
		end
		else if (mtd = '2') then begin
			while ((j > 1) and (temp.jumpen > fmr[j-1].jumpen)) do begin
				fmr[j]:=fmr[j-1];
				j:=j-1;
			end;
		end;
		fmr[j]:=temp;
	end;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Procedure SortJumdis(var fmr:Keluarga; jumdat:integer;mtd:string);
{I.S : Terdifinisi jumlah data dan metode pengurutannya.
 F.S : - }
var
	i,j,min:integer;
	temp:FamilyRecord;
begin
	for i:=1 to jumdat-1 do begin
		min:=i;
		if (mtd = '1') then begin
			for j:=i+1 to jumdat do begin
				if (fmr[min].jumdis > fmr[j].jumdis) then
					min:=j;
				//end if
			end;
		end
		else if (mtd = '2') then begin
			for j:=i+1 to jumdat do begin
				if (fmr[min].jumdis < fmr[j].jumdis) then
					min:=j;
				//end if
			end;
		end;
		temp:=fmr[min];
		fmr[min]:=fmr[i];
		fmr[i]:=temp;
	end;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Procedure SortJumblt(var fmr:Keluarga; jumdat:integer;mtd:string);
{I.S : Terdifinisi jumlah data dan metode pengurutannya.
 F.S : - }
var
	i,j,min:integer;
	temp:FamilyRecord;
begin
	for i:=1 to jumdat-1 do begin
		min:=i;
		if (mtd = '1') then begin
			for j:=i+1 to jumdat do begin
				if (fmr[min].jumblt > fmr[j].jumblt) then
					min:=j;
				//end if
			end;
		end
		else if (mtd = '2') then begin
			for j:=i+1 to jumdat do begin
				if (fmr[min].jumblt < fmr[j].jumblt) then
					min:=j;
				//end if
			end;
		end;
		temp:=fmr[min];
		fmr[min]:=fmr[i];
		fmr[i]:=temp;
	end;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Procedure MenuCari(var pilcari:string);
{I.S : User menginputkan pilihan
 F.S : Mengembalikan pilihan.}
begin
	clrscr;
	writeln('================[ Emerald City Database ]================');
	writeln('=                                                       =');
	writeln('======================[ MAIN MENU ]======================');
	writeln('                                                         ');
	writeln('       1. Cari Berdasarkan Nomor Kartu Keluarga          ');
	writeln('       2. Cari Berdasarkan Nama Kepala Keluarga          ');
	writeln('       3. Kembali                                        ');
	writeln('                                                         ');
	writeln('=========================================================');
	write  ('  Masukkan pilihan anda : ');readln(pilcari);
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Procedure SortMethod(var pilmethod:string);
{I.S : User menginputkan pilihan
 F.S : Mengembalikan pilihan.}
begin
	clrscr;
	writeln('================[ Emerald City Database ]================');
	writeln('=                                                       =');
	writeln('======================[ MAIN MENU ]======================');
	writeln('                                                         ');
	writeln('        1. Urutkan Secara Ascending                      ');
	writeln('        2. Urutkan Secara Descending                     ');
	writeln('        3. Kembali                                       ');
	writeln('                                                         ');
	writeln('=========================================================');
	write  ('  Masukkan pilihan anda : ');readln(pilmethod);
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Procedure MenuLihat(var pillihat:string);
{I.S : User menginputkan pilihan
 F.S : Mengembalikan pilihan.}
begin
	clrscr;
	writeln('================[ Emerald City Database ]================');
	writeln('=                                                       =');
	writeln('======================[ MAIN MENU ]======================');
	writeln('                                                         ');
	writeln('       1. Urutkan Berdasarkan Nomor Kartu Keluarga       ');
	writeln('       2. Urutkan Berdasarkan Nama Kepala Keluarga       ');
	writeln('       3. Urutkan Berdasarkan Jumlah Keluarga            ');
	writeln('       4. Urutkan Berdasarkan Jumlah Pendapatan          ');
	writeln('       5. Urutkan Berdasarkan Jumlah Disabilitas         ');
	writeln('       6. Urutkan Berdasarkan Jumlah BLT                 ');
	writeln('       7. Kembali                                        ');
	writeln('                                                         ');
	writeln('=========================================================');
	write  ('  Masukkan pilihan anda : ');readln(pillihat);
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Procedure Menu(var fmr:keluarga; var jumdat:integer);
{I.S : User menginputkan pilihan
 F.S : - }
var
	pilmenu,pilcari,pillihat,pilmethod: string;
begin
	repeat
		clrscr;
		writeln('================[ EMERALD CITY DATABASE ]================');
		writeln('=                                                       =');
		writeln('======================[ MAIN MENU ]======================');
		writeln;
		writeln('                     1. Tambah Data');
		writeln('                     2. Hapus Data');
		writeln('                     3. Edit Data');
		writeln('                     4. Cari Data');
		writeln('                     5. Lihat Data');
		writeln('                     6. Keluar');
		writeln;
		writeln('=========================================================');
		write  ('= Masukkan pilihan anda : ');read(pilmenu);
		Case pilmenu of
			'1':begin
				TambahData(fmr,jumdat);
			end;
			'2':begin
				HapusData(fmr,jumdat);
			end;
			'3':begin
				EditData(fmr,jumdat);
			end;
			'4':begin
				repeat
					MenuCari(pilcari);
					case pilcari of
						'1':begin
							SrchNokk(fmr,jumdat);
						end;
						'2':begin
							SrchKepkel(fmr,jumdat);
						end;
					end;
				until(pilcari = '3');
			end;
			'5':begin
				repeat
					MenuLihat(pillihat);
					Case pillihat of
						'1':begin
							repeat
								SortMethod(pilmethod);
								Case pilmethod of
									'1':begin
										SortNokk(fmr,jumdat,pilmethod);
										LihatData(fmr,jumdat);
									end;
									'2':begin
										SortNokk(fmr,jumdat,pilmethod);
										LihatData(fmr,jumdat);
									end;
								end;
							until (pilmethod = '3');
						end;
						'2':begin
							repeat
								SortMethod(pilmethod);
								Case pilmethod of
									'1':begin
										SortKepkel(fmr,jumdat,pilmethod);
										LihatData(fmr,jumdat);
									end;
									'2':begin
										SortKepkel(fmr,jumdat,pilmethod);
										LihatData(fmr,jumdat);
									end;
								end;
							until (pilmethod = '3');
						end;
						'3':begin
							repeat
								SortMethod(pilmethod);
								Case pilmethod of
									'1':begin
										SortJumkel(fmr,jumdat,pilmethod);
										LihatData(fmr,jumdat);
									end;
									'2':begin
										SortJumkel(fmr,jumdat,pilmethod);
										LihatData(fmr,jumdat);
									end;
								end;
							until (pilmethod = '3');
						end;
						'4':begin
							repeat
								SortMethod(pilmethod);
								Case pilmethod of
									'1':begin
										SortJumpen(fmr,jumdat,pilmethod);
										LihatData(fmr,jumdat);
									end;
									'2':begin
										SortJumpen(fmr,jumdat,pilmethod);
										LihatData(fmr,jumdat);
									end;
								end;
							until (pilmethod = '3');
						end;
						'5':begin
							repeat
								SortMethod(pilmethod);
								Case pilmethod of
									'1':begin
										SortJumdis(fmr,jumdat,pilmethod);
										LihatData(fmr,jumdat);
									end;
									'2':begin
										SortJumdis(fmr,jumdat,pilmethod);
										LihatData(fmr,jumdat);
									end;
								end;
							until (pilmethod = '3');
						end;
						'6':begin
							repeat
								SortMethod(pilmethod);
								Case pilmethod of
									'1':begin
										SortJumblt(fmr,jumdat,pilmethod);
										LihatData(fmr,jumdat);
									end;
									'2':begin
										SortJumblt(fmr,jumdat,pilmethod);
										LihatData(fmr,jumdat);
									end;
								end;
							until (pilmethod = '3');
						end;
					end;
				until(pillihat = '7');
			end;
		end;
	until(pilmenu = '6');
end;

Begin
	clrscr;
	//
	if FileExists('fileklr.dat') then begin
		assign(fileklr,'fileklr.dat');
		reset(fileklr);
		read(fileklr,fmr);
		close(fileklr);
	end
	else begin
		assign(fileklr,'fileklr.dat');
		rewrite(fileklr);
		jumdat:=0;
		write(fileklr,fmr);
		close(fileklr);
	end;
	//
	if FileExists('jumklr.dat') then begin
		assign(jumklr,'jumklr.dat');
		reset(jumklr);
		read(jumklr,jumdat);
		close(jumklr);
	end
	else begin
		assign(jumklr,'jumklr.dat');
		rewrite(jumklr);
		write(jumklr,jumdat);
		close(jumklr);
	end;
	
	Menu(fmr,jumdat);
	
	Assign(fileklr,'fileklr.dat');
	rewrite(fileklr);
	write(fileklr,fmr);
	close(fileklr);
	//
	Assign(jumklr,'jumklr.dat');
	rewrite(jumklr);
	write(jumklr,jumdat);
	close(jumklr);
End.