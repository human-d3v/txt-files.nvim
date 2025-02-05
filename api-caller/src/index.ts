import {type ResponseObject, type LuaTable} from './apiTypes';
import {Command} from 'commander';

async function makeApiCall(word: string):Promise<ResponseObject> {
	const url:string = "https://api.dictionaryapi.dev/api/v2/entries/en/" + word;
	const data = await fetch(url).then(res => res.json());
	const parsed = data[0] as ResponseObject
	return parsed
}


function luaTableFromResponse(resp:ResponseObject):LuaTable {
	let table:LuaTable = {
		word: '',
		def: [],
		syn: []
	}
	table.word = resp.word;
	const defs: string[] = resp.meanings.flatMap((m) => {
			return m.definitions.flatMap((v) =>  { 
				return v.definition.replaceAll("'",'"')
			})
		}
	);
	const syns: string[] = resp.meanings.flatMap((m) => {
			return m.definitions.flatMap((v) =>  { 
				return v.synonyms.flatMap((s) => s.replaceAll("'",'"'))
			})
		}
	);
	table.def = defs;
	table.syn = syns;
	return table;
}


function luaTableStringFromObject(t:LuaTable):string { 
	let defStr:string = "{'" + t.def.join("','") + "'}";
	let synStr:string = "{'" + t.syn.join("','") + "'}";
	return '{"word"="' + t.word + '", "def"=' + defStr + ',"syn"=' + synStr + '}';
} // outputs a string '{"word"="", "def"={}, "syn"={}}'


const program = new Command();

program.name('dict-api')
	.description(`A CLI for calling the the Dictionary API to render a 
							 definition or synonym in Neovim. 
							 | Options | -w --word <word> |
							 Example: dict-api -w "disincentive"`)
	.option('-w, --word <word>')
	.parse(process.argv)

async function main(){
	const options = program.opts();
	const word = options.word;
	let luaTableString:string = await makeApiCall(word)
		.then((resp)=> {
			return luaTableStringFromObject(
				luaTableFromResponse(resp)
			)
		})
		.catch((e) => 
					 '{"word"="' + word + '","def"={"No definition found"},"syn"={}}');
	
	console.log(luaTableString)
}	

main();
