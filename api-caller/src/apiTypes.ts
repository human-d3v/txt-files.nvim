export interface PhoneticObject {
	text: string;
	audio: string;
}


export interface DefinitionObject {
	definition: string;
	example: string;
	synonyms: string[];
	antonyms: string[];
}

export interface MeaningObject {
	partOfSpeech: string;
	definitions: DefinitionObject[];
}

export interface ResponseObject {
	word: string;
	phonetic: string;
	phonetics: PhoneticObject[];
	origin: string;
	meanings: MeaningObject[];
}

export interface LuaTable {
	word: string;
	def: string[];
	syn: string[];
}
