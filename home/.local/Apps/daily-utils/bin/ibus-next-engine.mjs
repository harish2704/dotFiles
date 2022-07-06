#!/usr/bin/env zx


let engineList = await $`ibus read-config | grep preload-engines | sed "s/preload-engines://g; s/'/\\"/g"`

engineList = JSON.parse(engineList)

let currentEngine = await $`ibus engine`
currentEngine = currentEngine.toString().trim()

let currentEngineIdx = engineList.indexOf(currentEngine);

let nextEngineIdx = currentEngineIdx+1;
if( nextEngineIdx === engineList.length ){
    nextEngineIdx=0
}

await $`ibus engine ${engineList[nextEngineIdx]}`
