<script>
    import "carbon-components-svelte/css/white.css";
    import {
        Checkbox,
        TextInput,
        Form,
        FormGroup,
        FormItem,
        Button,
        FormLabel,
    } from "carbon-components-svelte";
    import RowInsert from "carbon-icons-svelte/lib/AddFilled.svelte";
    import RowDelete from "carbon-icons-svelte/lib/TrashCan.svelte";
    export let headers = [{ id: 0, key: "", value: "" }];

    let index = 0;
    $: newLine = { id: index + 1, key: "", value: "" };
    function addItem() {
        // console.log(headers);
        index += 1;
        headers.push(newLine);
        headers = headers;
    }
    function deleteItem() {
        index -= 1;
        headers.pop();
        headers = headers;
    }
</script>

<div>
    <div class="row">
        <div class="clos"><span>KEY</span></div>
        <div class="clos" style="border-left: 0.5px solid silver;">
            <span>VALUE</span>
        </div>
    </div>
    {#each headers as { id, key, value } (id)}
        <div class="row">
            <TextInput
                class="clos"
                placeholder="key"
                bind:value={key}
                style="ma"
            />

            <TextInput
                class="clos"
                placeholder="value"
                bind:value
                style="margin-left:10px;"
            />
        </div>
    {/each}
    <Button
        kind="tertiary"
        size="small"
        iconDescription="row insert"
        on:click={addItem}
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
    .row {
        display: flex;
        border-left: 1px solid silver;
        border-right: 1px solid silver;
        border-bottom: 0.5px solid silver;
        border-top: 0.5px solid silver;
        width: auto;
        padding: 5px;
        align-items: center;
        margin-left: 2px;
    }
    .clos {
        display: flex;
        width: 100%;
        height: 30px;
        align-items: center;
        padding-left: 8px;
    }
</style>
