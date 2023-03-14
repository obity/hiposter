<script>
    import "carbon-components-svelte/css/white.css";
    import {
        TextInput,
        Button,
        ContentSwitcher,
        Switch,
        TextArea,
    } from "carbon-components-svelte";

    export let result = "";
    export let outputHeight;
</script>

<div>
    <TextArea
        class="text"
        bind:value={result}
        style="height:{outputHeight}%;"
        light
    />
</div>
