import { StateStatus } from '../types/state-status.type';
import { TpLinkPlugInfoDto } from '../../models/devices/tp-link-plug-info.dto';

export type DeviceInfoState = {
    status: StateStatus;
    syncActive: boolean;
    device?: TpLinkPlugInfoDto;
    errorMessage?: string;
    errorStatus?: number;
};

export enum DeviceActionNames {
    DEVICE_LOADING = 'DEVICE_LOADING',
    DEVICE_SYNC_STATUS_OK = 'DEVICE_SYNC_STATUS_OK',
    DEVICE_SET_POWER_STATE_OK = 'DEVICE_SET_POWER_STATE_OK',
    DEVICE_GET_OK = 'DEVICE_GET_OK',
    DEVICE_ERROR = 'DEVICE_ERROR',
}

export type DeviceAction<T> = {
    type: DeviceActionNames;
    payload: T;
};
