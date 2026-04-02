import os

from cryptography.exceptions import InvalidTag
from cryptography.hazmat.primitives.ciphers.aead import ChaCha20Poly1305


def encrypt_message(plaintext: bytes, key: bytes, aad: bytes = b"") -> tuple[bytes, bytes]:
    nonce = os.urandom(12)
    cipher = ChaCha20Poly1305(key)
    ciphertext = cipher.encrypt(nonce, plaintext, aad)
    return nonce, ciphertext


def decrypt_message(nonce: bytes, ciphertext: bytes, key: bytes, aad: bytes = b"") -> bytes | None:
    cipher = ChaCha20Poly1305(key)
    try:
        return cipher.decrypt(nonce, ciphertext, aad)
    except InvalidTag:
        return None
