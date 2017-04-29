import { getRandomAddress } from 'env'
import { without } from 'lodash'

import {
  RECEIVE_WEB3_ACCOUNTS
} from 'store/ethereum/web3'

import {
  RECEIVE_FAUCET,
  RECEIVE_FAUCET_ADDRESSES,
  RECEIVE_FAUCET_OBJECTS,
  FAUCET_CREATED,
  FAUCET_UPDATED,
  getFaucetByCreator,
  getAllFaucetObjects
} from './actions'

export const initialState = {
  addresses: [],
  objects: [],
  selected: null,
  defaultAddress: null,
  defaultFaucet: null
}

import { store } from 'main'

export const faucetReducer = (state = initialState, action) => {
  if (action.type === RECEIVE_WEB3_ACCOUNTS) {
    let defaultAddress = getRandomAddress(action.payload)
    // let defaultAddress = action.payload[0];
    store.dispatch(getFaucetByCreator(defaultAddress))

    store.dispatch(getAllFaucetObjects())

    return Object.assign({}, state, {
      defaultAddress: defaultAddress
    })
  }

  if (action.type === RECEIVE_FAUCET) {
    let faucet = action.payload;
    let defaultFaucet;
    if (faucet && faucet.creator === state.defaultAddress) {
      defaultFaucet = faucet;
    }
    return Object.assign({}, state, {
      selected: faucet,
      isOwner: faucet && faucet.creator === state.defaultAddress,
      defaultFaucet: defaultFaucet
    })
  }

  if (action.type === RECEIVE_FAUCET_ADDRESSES) {
    return Object.assign({}, state, {
      addresses: without(action.payload, 0)
    })
  }

  if (action.type === RECEIVE_FAUCET_OBJECTS) {
    return Object.assign({}, state, {
      objects: action.payload
    })
  }

  if (action.type === FAUCET_CREATED) {
    store.dispatch(getFaucetByCreator(state.defaultAddress))

    return Object.assign({}, state, {
      addresses: state.addresses.concat(action.payload.logs[0].address)
    })
  }

  if (action.type === FAUCET_UPDATED) {
    console.log('state.selected:', state.selected.balance)
    return Object.assign({}, state, {
      selected: {
        ...state.selected,
        balance: state.selected.balance - 1
      }
    })
  }

  return state
}
