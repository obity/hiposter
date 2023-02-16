<script>
    import "carbon-components-svelte/css/white.css";
    import {
        TextInput,
        Button,
        ContentSwitcher,
        Switch,
        TextArea,
    } from "carbon-components-svelte";
</script>

<div class="response">
    <TextArea labelText="Response" placeholder="返回结果" rows={15} />
</div>

<style>
    .response {
        text-align: left;
        border: 1px solid silver;
        margin-top: 5px;
        width: auto;
        height: auto;
        text-align: left;
        padding: 8px;
    }
</style>
