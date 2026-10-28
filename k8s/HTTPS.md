# Panduan HTTPS untuk Website di ACK (Alibaba Cloud) — ALB Ingress

Website ini di-expose melalui **ALB Ingress** (`kubernetes.io/ingress.class: alb`).
Ada **2 opsi** untuk mengaktifkan HTTPS otomatis:

| | Opsi A: Fitur Bawaan Alibaba Cloud | Opsi B: cert-manager + Let's Encrypt |
|---|---|---|
| Cara kerja | Sertifikat dibeli/upload di **SSL Certificates Service (CAS)**, controller ALB otomatis menemukannya dari `spec.tls.hosts` | cert-manager mengeluarkan sertifikat **gratis** ke Kubernetes Secret, controller ALB otomatis menyinkronkan Secret tsb ke ALB |
| Perlu instalasi tambahan | Tidak (komponen bawaan klaster ACK) | Ya (cert-manager di klaster) |
| Biaya sertifikat | Gratis 20 DV/thn (berlaku 3 bulan, perpanjangan manual) / berbayar | Gratis selamanya (Let's Encrypt) |
| Perpanjangan otomatis penuh | Ya, hanya untuk sertifikat berbayar | Ya (90 hari, auto-renew) |
| Cocok untuk | Mulai cepat / sudah punya sertifikat | Ingin gratis & 100% otomatis |

> **Catatan penting:** Controller ALB Ingress adalah satu-satunya pengelola ALB Anda.
> Jangan mengubah listener/sertifikat ALB secara manual dari console load balancer —
> perubahan manual akan **ditimpa kembali** oleh controller.

---

## Opsi A — Otomatis, Fitur Bawaan Alibaba Cloud (dipakai di `deployment.yaml`)

Pada klaster ACK standar, komponen ALB Ingress Controller terpasang sebagai add-on
terkelola dan mendukung **automatic certificate discovery**: cukup isi domain di
`spec.tls` Ingress, controller otomatis mencocokkan sertifikat yang ada di SSL
Certificates Service (berdasarkan CN/SAN, termasuk wildcard `*.domain.com`) lalu
memasangnya ke listener HTTPS:443. **Tidak perlu Kubernetes Secret atau cert-manager.**

### Langkah-langkah

1. **Siapkan sertifikat** di konsol SSL Certificates Service:
   <https://yundun.console.aliyun.com/?p=cas>
   - Gratis: tab **Free Certificates → Create Certificate (DV)**, lalu **Submit for Review**
     (validasi domain, berlaku ~3 bulan, maksimal 20 gratis per tahun, perpanjangan manual).
   - Atau upload sertifikat berbayar/external yang sudah Anda miliki.
   - **Region sertifikat harus sama dengan region klaster: `ap-southeast-5` (Jakarta)**.

2. **Edit `k8s/deployment.yaml`**: ganti `www.domain-anda.com` (2 tempat: di `spec.tls.hosts`
   dan di `spec.rules[].host`) dengan domain Anda, lalu commit & push. Ingress final:

   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: Ingress
   metadata:
     name: try-gel-ingress
     annotations:
       kubernetes.io/ingress.class: alb
       alb.ingress.kubernetes.io/listen-ports: '[{"HTTP": 80},{"HTTPS": 443}]'
       alb.ingress.kubernetes.io/ssl-redirect: "true"
   spec:
     tls:
     - hosts:
       - www.domain-anda.com      # GANTI dengan domain Anda
     rules:
     - host: www.domain-anda.com  # GANTI dengan domain Anda
       http:
         paths:
         - path: /
           pathType: Prefix
           backend:
             service:
               name: try-gel-svc
               port:
                 number: 80
   ```

   - `alb.ingress.kubernetes.io/ssl-redirect: "true"` → semua request HTTP:80
     otomatis di-redirect **301** ke HTTPS:443.
   - ⚠️ **Push hanya setelah sertifikat ada di CAS**, kalau tidak controller error:
     `none certificate found for host`.
