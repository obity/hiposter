<script>
    export let result = "";
</script>

<textarea class="text" bind:value={result} />

<style>
    .text {
        position: absolute;
        overflow-y: auto;
        height: 100%;
        width: 100%;
        font-size: 13px;
    }
</style>
