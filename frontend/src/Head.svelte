<script>
    import "carbon-components-svelte/css/white.css";
    import {
        Select,
        SelectItem,
        TextInput,
        Button,
    } from "carbon-components-svelte";

    let methods = ["GET", "POST", "PATCH", "DELETE", "HEAD"];
    export let theMethod;
    export let url = "";
    export let btnValue = "Send";
</script>

<h6>{url}</h6>
<div class="myhead">
    <Select
        noLabel
        size="sm"
        on:change={(e) => console.log("theMethod", theMethod)}
        bind:selected={theMethod}
    >
        {#each methods as m}
            <SelectItem value={m} />
        {/each}
    </Select>
    <div id="url">
        <TextInput
            hideLabel
            labelText="url"
            size="sm"
            bind:value={url}
            placeholder="Enter Request URL..."
        />
    </div>
    <Button on:click type="submit" size="small">{btnValue}</Button>
</div>

<style>
    h6 {
        display: flex;
        align-items: center;
        height: 30px;
        margin-left: 20px;
    }
    .myhead {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
        -webkit-border-radius: 15px;
        -moz-border-radius: 15px;
        border-radius: 15px;
        border: 2px solid #4c9fe9;
        padding: 20px;
        /* box-shadow: 5px 5px 5px #888888; */
    }

    #url {
        width: 90%;
        margin-left: 5px;
        margin-right: 5px;
        border: 2px black;
    }
</style>
