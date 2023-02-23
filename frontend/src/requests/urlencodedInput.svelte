<script>
    import "carbon-components-svelte/css/white.css";
    import { TextInput, Button } from "carbon-components-svelte";
    import RowInsert from "carbon-icons-svelte/lib/AddFilled.svelte";
    import RowDelete from "carbon-icons-svelte/lib/TrashCan.svelte";
    import { writable } from "svelte/store";
    let headers = [{ id: 0, key: "", value: "" }];
    export let urlencodedBody = "";
   

    let index;
    const count = writable(1);
    const unsubscribe = count.subscribe((value) => {
        index = value;
        // console.log(index);
    });
    $: newLine = { id: index, key: "", value: "" };
    $:{
        let arr = [];
        for (const h of headers) {
            if (h.key != "") {
                arr.push(h.key +'='+ h.value);
            }
        }
        urlencodedBody = arr.join("&");
    }
    function addItem() {
        count.update((n) => n + 1);
        headers.push(newLine);
        headers = headers;
    }
    function deleteItem() {
        count.update((n) => n - 1);
        headers.pop();
        headers = headers;
    }
</script>

<div style="overflow: auto;height:280px">
    <div class="title">
        <div class="clos"><span>KEY</span></div>
        <div class="clos" style="border-left: 0.5px solid silver;">
            <span>VALUE</span>
        </div>
    </div>
    {#each headers as { id, key, value } (id)}
        <div class="row">
            <TextInput
                class="clos"
                placeholder="Key"
                bind:value={key}
                size="sm"
                light
                style="border-bottom: 0;"
            />

            <TextInput
                class="clos"
                placeholder="Value"
                bind:value
                size="sm"
                light
                style="margin-left:0px;border-bottom: 0;border-left:1px solid silver"
            />
        </div>
    {/each}
    <Button
        kind="tertiary"
        size="small"
        iconDescription="row insert"
        on:click={addItem}
        on:click
        icon={RowInsert}
    />
    <Button
        kind="tertiary"
        size="small"
        iconDescription="row delete"
        on:click={deleteItem}
        icon={RowDelete}
    />
</div>

<style>
    .title {
        display: flex;
        border-left: 1px solid silver;
        border-right: 1px solid silver;
        border-bottom: 0.5px solid silver;
        border-top: 1px solid silver;
        width: auto;
        align-items: center;
    }
    span {
        margin-left: 15px;
        font-weight: bold;
    }
    .row {
        display: flex;
        border-left: 1px solid silver;
        border-right: 1px solid silver;
        border-bottom: 0.5px solid silver;
        border-top: 0px solid silver;
        width: auto;
        align-items: center;
    }
    .clos {
        display: flex;
        width: 100%;
        height: 30px;
        align-items: center;
        text-align: left;
    }
</style>
