<script>
    import "carbon-components-svelte/css/white.css";
    import { TextArea } from "carbon-components-svelte";
    export let value;
</script>

<TextArea bind:value placeholder="请输入JSON数据" rows={15} light/>

<style>

</style>
