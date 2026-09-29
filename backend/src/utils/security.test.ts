import test from 'node:test';
import assert from 'node:assert/strict';
import { fileMatchesContent, hashToken, passwordIsStrong } from './security';

test('security helpers reject weak passwords and disguised uploads', () => {
  assert.equal(passwordIsStrong('password'), false);
  assert.equal(passwordIsStrong('aman1234'), true);
  assert.equal(fileMatchesContent(Buffer.from('not an image'), '.png'), false);
  assert.equal(fileMatchesContent(Buffer.concat([Buffer.from('89504e470d0a1a0a', 'hex'),Buffer.alloc(17)]), '.png'), true);
  assert.equal(hashToken('secret'), hashToken('secret'));
  assert.notEqual(hashToken('secret'), 'secret');
});
