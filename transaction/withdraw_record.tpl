
<table class="table tablelist">
  <colgroup>
    <col>
    <col>
    <col>
    <col>
    <col>
  </colgroup>
  <thead class="bg-light">
    <tr>
      <th class="pointer" prop="id">
        <span>ID</span>
        <span class="text-black-50 d-inline-flex flex-column justify-content-center ml-1 offset-3">
          <i class="bx bx-caret-up"></i>
          <i class="bx bx-caret-down"></i>
        </span>
      </th>
      <th class="pointer" prop="num">
        <span>{$Lang.amount_money}</span>
        <span class="text-black-50 d-inline-flex flex-column justify-content-center ml-1 offset-3">
          <i class="bx bx-caret-up"></i>
          <i class="bx bx-caret-down"></i>
        </span>
      </th>
      <th class="pointer" prop="des">
        <span>{$Lang.describe}</span>
        <span class="text-black-50 d-inline-flex flex-column justify-content-center ml-1 offset-3">
          <i class="bx bx-caret-up"></i>
          <i class="bx bx-caret-down"></i>
        </span>
      </th>
      <th class="pointer" prop="reason">
        <span>{$Lang.source}</span>
        <span class="text-black-50 d-inline-flex flex-column justify-content-center ml-1 offset-3">
          <i class="bx bx-caret-up"></i>
          <i class="bx bx-caret-down"></i>
        </span>
      </th>
      <th class="pointer" prop="create_time">
        <span>{$Lang.withdrawal_time}</span>
        <span class="text-black-50 d-inline-flex flex-column justify-content-center ml-1 offset-3">
          <i class="bx bx-caret-up"></i>
          <i class="bx bx-caret-down"></i>
        </span>
      </th>
    </tr>
  </thead>
  <tbody>
    {if $Transaction}
    {foreach $Transaction as $list}
    <tr>
      <td>{$list.id}</td>
      <td>{if $list.refund}{$list.amount_in}{else}{$list.amount_out}{/if}</td>
      <td>{$list.description}</td>
      <td>{$list.description}</td>
      <td>{$list.pay_time|date="Y-m-d H:i:s"}</td>
    </tr>
    {/foreach}
    {else}
    <tr>
      <td colspan="8">
        <div class="no-data">{$Lang.nothing}</div>
      </td>
    </tr>
    {/if}
  </tbody>
</table>