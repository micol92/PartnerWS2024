namespace sap.capire.bookshop;
using { sap } from '@sap/cds/common';

type GenreTypeCode : String enum {
	A; //> Novel
	B; //> Scientific
    C; //> Poem
}

@cds.autoexpose
entity GenreType : sap.common.CodeList {

	key ID: GenreTypeCode;
    parent   : Association to GenreType;
    children : Composition of many GenreType on children.parent = $self;
	description: localized String;
}