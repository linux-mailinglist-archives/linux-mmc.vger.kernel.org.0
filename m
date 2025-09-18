Return-Path: <linux-mmc+bounces-8197-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90F4B3AA5F
	for <lists+linux-mmc@lfdr.de>; Thu, 28 Aug 2025 20:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F7F203C5A
	for <lists+linux-mmc@lfdr.de>; Thu, 28 Aug 2025 18:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8F4285060;
	Thu, 28 Aug 2025 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8p7Ha3R"
X-Original-To: linux-mmc@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659BE30DEA1
	for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407182; cv=none; b=mnIPgJiK8ZuyZHlBX8eylRt7m2oAl4PlrHLLkeLEwLRsUPuipIKb1XnVDOamIdCWeVvmv909qcw+nR4ORYlR/MI7+7NNx+yd1bPx7Rv6fil3zhFMzvC6VvcSd14kdrBbgCPjlOQWHTrmCfyqRsZXPQXy2qF8Eo34zLsvN3/nDR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407182; c=relaxed/simple;
	bh=CgULwvBoKBpoCxSt14lLKe61Fel/Z9Jurl+x1vHCKzw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwRfk+O6KLWoAMxuAbZjPn5I3suMxXUMXx89Cr0xt8dAMVarc8cO+F42GQqVOKd2edOZbW/zGRTg+PH22orn6dpUafGaMlbMeGxZiFwO8+TuOhoLwTxBxSeOnV1J4A7j9fyIrvtssqw5X87fSMukU26n+MgoQ9EPP28wd6zcgng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8p7Ha3R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756407179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ox+fdqHLvqvHkCQcV7jSITHMPKa6EWT2tpRcTnamaBA=;
	b=R8p7Ha3RsimdvS9flqbcVndVCvHKgo45EKtOmpQA8EIPCsvVGQi+bsTJYQGLlSym62TPlG
	p7RGFYB6qGaBFpesTWpbAc0aJ6i28QbXhC/jzDcrZVlKGiIH7D2i2WuUSvMew555dBjmfX
	cq0jXEd8BmSh/AsNs51wNUj19YTY9Xg=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-GAl7_1HBNuKKlKvzZAaXXQ-1; Thu, 28 Aug 2025 14:52:57 -0400
X-MC-Unique: GAl7_1HBNuKKlKvzZAaXXQ-1
X-Mimecast-MFC-AGG-ID: GAl7_1HBNuKKlKvzZAaXXQ_1756407176
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e8dffcf41eso1108105ab.0
        for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 11:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756407176; x=1757011976;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ox+fdqHLvqvHkCQcV7jSITHMPKa6EWT2tpRcTnamaBA=;
        b=hpn945YfMmEJI7DLJHshMEWiYMyiaAGxGw5mPrTPiwb6UjH9jbdkqMXBBUnoaNGiWa
         cIO0cj6nse7RMm9CJ7TX+MlOhO7oJxUjmuSLVN49VJvkauliI/Pak51EJMNf35A7U80W
         43f8WWPZ5SDBSJ1JPzLbdrhcGagGqaAnJd5aVCZnRzPJ7ctLI3eHlkjXGkBtAlFxZsKX
         t9ZL51Vx300YjWKr97NGA+ocOgWkBQkbtYrm3s4utbT51c/P4AjuUDchfcdwW4tVxdJg
         MDalSVHK6FXbrz2WEtug991dDbJDhUiDdplUOokXEDNLh35BlHAgMGuRtsPWE1znCGJy
         pwfA==
X-Forwarded-Encrypted: i=1; AJvYcCXStsA+W9fuh+0WB/SeK/vbJlCrrE8EVMXJNShhTM1rUS7F6WIG4lqddPR82MNSISMfVYIzb/hjMtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxCbHFm23dxlgybVk9e6dY4veG4iIbSixDpk3DZ+0cACNcM4nn
	Y35SH1hQQcUYTONVayUBzY5POfFewM7xbTcL1GtPPTX4lsxx6fbJaZsONVIx7XTsYqwSmEoWtdp
	8cTUWhLfZqMMtM33+VuzWLcpvY1kmVNs4pvqO8pmauE+Rq8OxYk61icBiys66nA==
X-Gm-Gg: ASbGncvLvkKRwCCvjm0WiV863TJORl+nx/9jWkp7MyJTuUzAcidCDbMojrQfGNpe7VR
	pcyy+9tEJwZZA4b/E5Cq+VVK40SOtev9C3qZI07qnNNmOBychvQ/eCaaZh9YFJfV/yAcjZIWeff
	WF22uOhNw7uscQj6fcT1Jid/lfWaUP09aviWSDbET8PMEIX20bi9aQhnZ9u1iiT6VOLmiGatktC
	74nZUHzDh+d90O6UiL8N1ugYjns/T6cGhIl7E6LbNQo5sI+4ml6kjrmf1MQRVqga/h/EC10dkyM
	2ow5hPWjhkI66tQk8g5vmPad1ieZZyBLTuDRqPZEa7o=
X-Received: by 2002:a05:6e02:1a86:b0:3ee:cb14:e90f with SMTP id e9e14a558f8ab-3eecb14ea03mr61888845ab.7.1756407176422;
        Thu, 28 Aug 2025 11:52:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP6X5C8fKyFwSWmjzqPdfkbd7PprjZnYQm1xQXLb3Ss2KjE+y/MhfTqxlaUhO3jzRNfBiTrg==
X-Received: by 2002:a05:6e02:1a86:b0:3ee:cb14:e90f with SMTP id e9e14a558f8ab-3eecb14ea03mr61888495ab.7.1756407175934;
        Thu, 28 Aug 2025 11:52:55 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d78c67b4dsm47783173.7.2025.08.28.11.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 11:52:54 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:52:51 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Shameer
 Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian
 <kevin.tian@intel.com>, Alexander Potapenko <glider@google.com>, Andrew
 Morton <akpm@linux-foundation.org>, Brendan Jackman <jackmanb@google.com>,
 Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>, Dmitry
 Vyukov <dvyukov@google.com>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, iommu@lists.linux.dev,
 io-uring@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe
 <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, John Hubbard
 <jhubbard@nvidia.com>, kasan-dev@googlegroups.com, kvm@vger.kernel.org,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-arm-kernel@axis.com,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Marco Elver <elver@google.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>, Peter Xu
 <peterx@redhat.com>, Robin Murphy <robin.murphy@arm.com>, Suren
 Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
 wireguard@lists.zx2c4.com, x86@kernel.org, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v1 31/36] vfio/pci: drop nth_page() usage within SG
 entry
Message-ID: <20250828125251.08e4a429.alex.williamson@redhat.com>
In-Reply-To: <20250827220141.262669-32-david@redhat.com>
References: <20250827220141.262669-1-david@redhat.com>
	<20250827220141.262669-32-david@redhat.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 00:01:35 +0200
David Hildenbrand <david@redhat.com> wrote:

> It's no longer required to use nth_page() when iterating pages within a
> single SG entry, so let's drop the nth_page() usage.
> 
> Cc: Brett Creeley <brett.creeley@amd.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Yishai Hadas <yishaih@nvidia.com>
> Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/vfio/pci/pds/lm.c         | 3 +--
>  drivers/vfio/pci/virtio/migrate.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/pci/pds/lm.c b/drivers/vfio/pci/pds/lm.c
> index f2673d395236a..4d70c833fa32e 100644
> --- a/drivers/vfio/pci/pds/lm.c
> +++ b/drivers/vfio/pci/pds/lm.c
> @@ -151,8 +151,7 @@ static struct page *pds_vfio_get_file_page(struct pds_vfio_lm_file *lm_file,
>  			lm_file->last_offset_sg = sg;
>  			lm_file->sg_last_entry += i;
>  			lm_file->last_offset = cur_offset;
> -			return nth_page(sg_page(sg),
> -					(offset - cur_offset) / PAGE_SIZE);
> +			return sg_page(sg) + (offset - cur_offset) / PAGE_SIZE;
>  		}
>  		cur_offset += sg->length;
>  	}
> diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
> index ba92bb4e9af94..7dd0ac866461d 100644
> --- a/drivers/vfio/pci/virtio/migrate.c
> +++ b/drivers/vfio/pci/virtio/migrate.c
> @@ -53,8 +53,7 @@ virtiovf_get_migration_page(struct virtiovf_data_buffer *buf,
>  			buf->last_offset_sg = sg;
>  			buf->sg_last_entry += i;
>  			buf->last_offset = cur_offset;
> -			return nth_page(sg_page(sg),
> -					(offset - cur_offset) / PAGE_SIZE);
> +			return sg_page(sg) + (offset - cur_offset) / PAGE_SIZE;
>  		}
>  		cur_offset += sg->length;
>  	}

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


