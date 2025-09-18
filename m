Return-Path: <linux-mmc+bounces-7907-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65748B30439
	for <lists+linux-mmc@lfdr.de>; Thu, 21 Aug 2025 22:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD611CE64D4
	for <lists+linux-mmc@lfdr.de>; Thu, 21 Aug 2025 20:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032AF31280D;
	Thu, 21 Aug 2025 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IljkE2mg"
X-Original-To: linux-mmc@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7432FC032
	for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806857; cv=none; b=vCB15UAVWQX4o+74NfQ4WMdYYUdRxR3VrBFOZfiFRTI3nm6bZQB+M0KnmqKVI6PyilctwSJ4KwVhEzZkaaCB31V/mWBK5zajfSxYY+y4XZSHFGmWotL39YR62a7kOEtup33D+nvVh8nn9zeLivGE+voyN1TaOwsVgGouaC5El2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806857; c=relaxed/simple;
	bh=s79Oeg502W4xdw3NRVnr9AKhHVyvkgzn8FY1ksnzdKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovdL/biSCB/kZSA0LPkyVO2B+oXH0ffxzBnS1NcQy7k5woxRzfT1BQGpP71VOlGlkDMCAy+l0Zx000V5goO9Jeif3nnuXqpxaAL+otfe5tguyh2n6+lFwyM9lvP5kCymlagwgQPMsMPGOY3JNZnp4P0tuqW2si9CoOtXSfGf1No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IljkE2mg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9Znt0atqEjtEUkbTSfKRsvBJ9rEcbnqI7Kn1XkJSrA=;
	b=IljkE2mgp8AAtkLqlTNHe+Oy8Xi5/+sQ/jHb5Ye14J3SbKGyLEykn+tj58U9TQujoR1b0n
	qyJkdGaWCPF8+Wj50XUrwZzmuhltbMibwwxxf1vVGvmGf2BNykV/W2k7kmUsO1xMNlvdno
	DOoUB7XCSpTulXSFV/ZnDc2H1ofrlEU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-j9Nx07AdO_-gKSKiLHrq_A-1; Thu, 21 Aug 2025 16:07:28 -0400
X-MC-Unique: j9Nx07AdO_-gKSKiLHrq_A-1
X-Mimecast-MFC-AGG-ID: j9Nx07AdO_-gKSKiLHrq_A_1755806847
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b4d6f3ab0so8376895e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2025 13:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806847; x=1756411647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9Znt0atqEjtEUkbTSfKRsvBJ9rEcbnqI7Kn1XkJSrA=;
        b=CCZvJjEi77aW+F+M+KqtbDlP5ACkbIcZcs2ip6oIohP05fgwov46RoDqiSY+ZUbc1n
         wmaryD7DYD6KJ+iIV0zfOWigqc0X61p4X52JL3TTfN+/XqAusKLVzoixZyZ9XmlrNoCc
         uwFh2R8/XzI9LbU2+4z4LJP08dwswXRysksEpFr4pr9NXUNSo1xuBU3Yq30odAp2RRnY
         5cfgMQp6JhuNknT58E++MqHyJ7+Xj7yzO0y+kOqntds0Rqznjfss+KdyqpadagjsR0q/
         yBh8qu7oCtL/tUl5LwKmePOewK1sXs9w63M6z4+JPWruDKcZTpaYU2exrrs1ad0r3zXE
         Bppw==
X-Forwarded-Encrypted: i=1; AJvYcCUJMpzkJCf7hmEOKov++zQo+81Icb+DaUtwpmNHIMmBU6pOMa0ReiMSncKuGfaLV9RYQjSGAsjEREY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7+PiM3VaZq2g50SQzGEVXQ7yQxA3jj+lby1ojEnHkdGG8AMfx
	Ew9CTNJaQkT6CPhYYx9kK0Zz9Ij7V+IEWpLsIQxdVE80+X/O+jQSBCMSGSTSXcrrG9FmQDfKBwb
	KzaYndPyCx0C0ZMQmf74chqqNh4gMsMHQfuD/zfF7nbNiQcaTEBM7gxGctN8beg==
X-Gm-Gg: ASbGncvrlAfG/y83qBLLlOhGJMZV8xgKr+5qru5pOixpXtTnz66x7Au2QeLc+VTTS/h
	+V5Lw/JReLBqAGwWTtn5CDk6W42iWZeK8LgFl4T4wq3QZE8VGLZZ5ISm5BbJY56oAf2TelThxnG
	Czyxgh9rRD7qBmkxLI/Js5NgbrqafJ5C/cpkZr8Z1zDz/dKBp8wkYv/wKU8riAijzOU5rXLU/t+
	lfpTjuar6nAecpSqRiRX1y9zzbHwIdj4x0EbTyUjC5yky1pGAz6ZcAd5lVNhXX+N17d98TcKM9R
	O6Eakt1T/vPWTYoo58XF/W8K2id/o01q5GZuosN7xLfATL6rBnWzO33g+DUPQ3CVGiyEIvr1p8J
	lSF7w2njjMqXMS6xl4XcFEA==
X-Received: by 2002:a05:600c:3552:b0:459:dde3:1a33 with SMTP id 5b1f17b1804b1-45b517d26d4mr2922295e9.26.1755806847228;
        Thu, 21 Aug 2025 13:07:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUeapMM5JkcwJNJXC+LM6ICHu4lGUEF2ir46AAuHXhYXAFzTcPIdec/q/lplZD/isU7mGEgg==
X-Received: by 2002:a05:600c:3552:b0:459:dde3:1a33 with SMTP id 5b1f17b1804b1-45b517d26d4mr2921795e9.26.1755806846742;
        Thu, 21 Aug 2025 13:07:26 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50d62991sm9535385e9.0.2025.08.21.13.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:26 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 07/35] mm/memremap: reject unreasonable folio/compound page sizes in memremap_pages()
Date: Thu, 21 Aug 2025 22:06:33 +0200
Message-ID: <20250821200701.1329277-8-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's reject unreasonable folio sizes early, where we can still fail.
We'll add sanity checks to prepare_compound_head/prepare_compound_page
next.

Is there a way to configure a system such that unreasonable folio sizes
would be possible? It would already be rather questionable.

If so, we'd probably want to bail out earlier, where we can avoid a
WARN and just report a proper error message that indicates where
something went wrong such that we messed up.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memremap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memremap.c b/mm/memremap.c
index b0ce0d8254bd8..a2d4bb88f64b6 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -275,6 +275,9 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 
 	if (WARN_ONCE(!nr_range, "nr_range must be specified\n"))
 		return ERR_PTR(-EINVAL);
+	if (WARN_ONCE(pgmap->vmemmap_shift > MAX_FOLIO_ORDER,
+		      "requested folio size unsupported\n"))
+		return ERR_PTR(-EINVAL);
 
 	switch (pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
-- 
2.50.1


