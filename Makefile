
KNIFE=/usr/bin/knife
TAR=/bin/tar

TAR_FLAGS=-cpzf
TAR_EXCLUDE_FLAGS=--exclude .git --exclude .gitignore --exclude Makefile --exclude *.gz

OUTPUT_FILENAME="application_zf.tar.gz"

all:
	${KNIFE} cookbook metadata -o .. application_zf
	${TAR} ${TAR_FLAGS} ${OUTPUT_FILENAME} ${TAR_EXCLUDE_FLAGS} ../application_zf

clean:
	rm ${OUTPUT_FILENAME}

