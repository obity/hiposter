<script>
    import "carbon-components-svelte/css/white.css";
    import { TextArea } from "carbon-components-svelte";
    export let value;
    export let placeholder
</script>

<TextArea bind:value {placeholder} rows={15} light/>

<style>

</style>
