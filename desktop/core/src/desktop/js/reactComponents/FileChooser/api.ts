// Licensed to Cloudera, Inc. under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  Cloudera, Inc. licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

export const FILESYSTEMS_API_URL = '/api/v1/storage/filesystems';
export const FILE_STATS_API_URL = '/api/v1/storage/stat';
export const LIST_DIRECTORY_API_URL = '/api/v1/storage/list';
export const FILE_PREVIEW_API_URL = '/api/v1/storage/display';
export const DOWNLOAD_API_URL = '/filebrowser/download=';
export const CONTENT_SUMMARY_API_URL = '/api/v1/storage/content_summary';
export const SAVE_FILE_API_URL = '/api/v1/storage/save';
export const UPLOAD_FILE_URL = '/filebrowser/upload/file';
export const CHUNK_UPLOAD_URL = '/filebrowser/upload/chunks/file';
export const CHUNK_UPLOAD_COMPLETE_URL = '/filebrowser/upload/complete';
export const CREATE_FILE_API_URL = '/api/v1/storage/create/file/';
export const CREATE_DIRECTORY_API_URL = '/api/v1/storage/create/directory/';
export const RENAME_API_URL = '/api/v1/storage/rename/';
export const SET_REPLICATION_API_URL = '/api/v1/storage/replication/';
export const COPY_API_URL = '/api/v1/storage/copy/';
export const BULK_COPY_API_URL = '/api/v1/storage/copy/bulk/';
export const MOVE_API_URL = '/api/v1/storage/move/';
export const BULK_MOVE_API_URL = '/api/v1/storage/move/bulk/';

export interface ApiFileSystem {
  file_system: string;
  user_home_directory: string;
}
