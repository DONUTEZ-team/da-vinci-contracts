type token_id is nat

type account is record [
  balance : map(token_id, nat);
  allowances : set(address);
]

type token_metadata_info is record [
  token_id : token_id;
  extras : map(string, bytes);
]

type storage is record [
  ledger : big_map(address, account);
  token_metadata : big_map(token_id, token_metadata_info);
  metadata : big_map(string, bytes);
  lastTokenId : nat;
]

type return is list (operation) * storage

type transfer_destination is [@layout:comb] record [
  to_ : address;
  token_id : token_id;
  amount : nat;
]

type transfer_param is [@layout:comb] record [
  from_ : address;
  txs : list(transfer_destination);
]

type balance_of_request is [@layout:comb] record [
  owner : address;
  token_id : token_id;
]

type balance_of_response is [@layout:comb] record [
  request : balance_of_request;
  balance : nat;
]

type balance_params is [@layout:comb] record [
  requests : list(balance_of_request);
  callback : contract(list(balance_of_response));
]

type operator_param is [@layout:comb] record [
  owner : address;
  operator : address;
  token_id : token_id;
]

type update_operator_param is
| Add_operator of operator_param
| Remove_operator of operator_param

type transfer_params is list(transfer_param)

type update_operator_params is list(update_operator_param)

type mint_token_params is map(string, bytes)

type token_action is
| Transfer of transfer_params
| Balance_of of balance_params
| Update_operators of update_operator_params
| Mint_token of mint_token_params

[@inline] const noOperations : list(operation) = nil;
