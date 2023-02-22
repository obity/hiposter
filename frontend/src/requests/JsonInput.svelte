<script>
    import "carbon-components-svelte/css/white.css";
    import { TextArea } from "carbon-components-svelte";
    export let value;
</script>

<TextArea
    bind:value
    placeholder="Please enter the request data here."
    light
    style="border: 1px solid silver;overflow: auto;height:280px"
/>

<style>
</style>
