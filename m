Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D353A4822
	for <lists+linux-mmc@lfdr.de>; Fri, 11 Jun 2021 19:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFKR5K (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 11 Jun 2021 13:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhFKR5J (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Jun 2021 13:57:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A36C0617AF
        for <linux-mmc@vger.kernel.org>; Fri, 11 Jun 2021 10:55:11 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g24so6101720pji.4
        for <linux-mmc@vger.kernel.org>; Fri, 11 Jun 2021 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FiCqgV8kjys+3xuqiyCwJtcf1Wj53LQ5ch2SqyLytgY=;
        b=SD6IZ6g/PQccK+DJj47BNWbjBcu51Hoxg75XX8W0NsqQBg0ABF+hnuOUc/UFnpm8im
         oNVX3uykvZuuO5Y8ikPd3y+WsvzDFhqLGs4yWHQFnc8RzIYufWCIOXqn3AApkjH4Q2eg
         xQaVfA+BsocsKdfD6NHf1Rfl2fMGnqoxNR3DdZP0eXDcQ/vjXZbD88x8d17C79EnssGA
         MaA3XiWo9+AFyaOrA1MdfYif3vi99movLQHJefeIj5rihTG1TSe1D2qp8+37dXVxo+jK
         juNRW5LpLgfCfOOUxjWz+2zHY1TAZQqD4FUpZkK9KYz4TPA/VoJTiiPZCp8OQM00GFzi
         g76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FiCqgV8kjys+3xuqiyCwJtcf1Wj53LQ5ch2SqyLytgY=;
        b=KEnRE4NWaPWf3KZk+eaB0t4o+eUw9xiR6tqYFsUyt1CII5zea125lWKtmn1GhI0+Ix
         2cwZtVQIAGnlXvh/HTLSXUtRyvzovsk4jWCO1+XjnMeS4sZcHup/hIR4AO0RpuVaNHmw
         Ts/RL8nsiOeSknuk6OVINkkBCl7gTsxXs+z2F8XxMdWDaJn/k+o7fOFtX2Xg0m/JU+Ec
         m2dX6IUNW67CjMcSSmNoTagN5Fgu+wkyCtx2HPHpAgvgJ5kAyNjnmxsxPWpq8MTKrs/k
         JBLLAcUpHr0drmBEXkdB6bMcET+gWB3Knp6FcoDGnRwAYi6iCsh78lI180U2C45Y0Usv
         v0mw==
X-Gm-Message-State: AOAM5323coIRs7YXnUYnyZdHZvVvg43OSCURhX3ryudKSzQeQ9hYr2gg
        EkWov3u4n3OPvDfgx+BQfEkTMg==
X-Google-Smtp-Source: ABdhPJxMGSnZ9kJAsN6p7k0McSncvftPUJip5kVUuOxTF3REguFHe02Lgz4i9/8fJhn7M2nOfjp+aA==
X-Received: by 2002:a17:90a:9481:: with SMTP id s1mr5656508pjo.48.1623434110978;
        Fri, 11 Jun 2021 10:55:10 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id x3sm6384950pgx.8.2021.06.11.10.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 10:55:10 -0700 (PDT)
Subject: Re: simplify gendisk and request_queue allocation for blk-mq based
 drivers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Justin Sanders <justin@coraid.com>,
        Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Tim Waugh <tim@cyberelk.net>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org
References: <20210602065345.355274-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fa9590e3-20eb-5215-d2f7-6489169c232c@kernel.dk>
Date:   Fri, 11 Jun 2021 11:55:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210602065345.355274-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/2/21 12:53 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series is the scond part of cleaning up lifetimes and allocation of
> the gendisk and request_queue structure.  It adds a new interface to
> allocate the disk and queue together for blk based drivers, and uses that
> in all drivers that do not have any caveats in their gendisk and
> request_queue lifetime rules.

Applied, thanks.

-- 
Jens Axboe

