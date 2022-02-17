Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8784B9611
	for <lists+linux-mmc@lfdr.de>; Thu, 17 Feb 2022 03:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiBQCs0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 16 Feb 2022 21:48:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiBQCsZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2022 21:48:25 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A921FFF65
        for <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2022 18:48:12 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id g1so3807416pfv.1
        for <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2022 18:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=z4i3sOJXuX5pLimLJFSpC+ldhVIHQTJAyQCIIZg6vB0=;
        b=MAKfpeBarFVBWwQcysBwZiWFmuKrF2I+yyKafwWHcLfuPTLpj5AhAFFMGSOS1ptpVW
         BYaxp5/QaxDBE1pbWlzrWulYvblHF3P7HnUm40geVqEe/CWtocilVYmWtBMQzvgh7gBP
         SbAi45TriQv1LDZ2FyoWNZKj3/g8YKlnllG9oTlhCX6attCGW/oTE70mpGrFw+Mm37eD
         LqBsarqyBz7pJPWcP7lS0PVSDwRX7c2kZZjb0yAi580ERYzK4vlWMpLyB6+sBS9G1+2S
         R+di0YkeuwdBoSGR3bQktJMmbNdIuykrRs4AADH7x+Gtr0RqPEq4USsFnolA7nsMWr9W
         XLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=z4i3sOJXuX5pLimLJFSpC+ldhVIHQTJAyQCIIZg6vB0=;
        b=xSpuDZNKwnr68uFD4IgkXNDKIgh3hD+puKVL5xTdOrLfPzZBTBbaTk1DkipbWkNU+J
         Tc5GWCRKqVyGlkEVN/8rqrcldb6wKozD6LYfBP0mZoHaAB1+hCSdgic+o/ziZMrWU/YR
         hm9j48s/98E02UwfFUviauafxnBZmhI8m8+eOxuPq9tcCg5RBmmjLQ0bGciX7hSsDEXH
         Zmoo1RvZL59mUdeS7sNHUNelwwOYeetxAgrh2bZ1MaCYFV8tp13kASRN7PD37z6fXDbo
         vraDfSoC1bbNGa/xldDlEFhzh3QITGuE+UIsuoo/TJ6qnjil+1OXAbAv9Dg9sxVL84bX
         4PKQ==
X-Gm-Message-State: AOAM5322x832Iduh3tINd9Aogey61vZcNTOqem5hxm8MhSICx1bGl6lu
        p0jiHP65wFh3EWAAVfo4raNt9Q==
X-Google-Smtp-Source: ABdhPJzvExI+t8yuXaS1DEStOCB4GW78Viv/TkR5lL+Qjf2kAF0uOwLJYp8MNv5DGGmehSRGmJjLtw==
X-Received: by 2002:a05:6a00:124a:b0:4e1:7cfb:634c with SMTP id u10-20020a056a00124a00b004e17cfb634cmr1100314pfi.12.1645066091528;
        Wed, 16 Feb 2022 18:48:11 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id lw3sm377109pjb.24.2022.02.16.18.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 18:48:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-block@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        virtualization@lists.linux-foundation.org,
        linux-mmc@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220215094514.3828912-1-hch@lst.de>
References: <20220215094514.3828912-1-hch@lst.de>
Subject: Re: add a ->free_disk block_device_operation v3
Message-Id: <164506608998.50072.6316036301772123687.b4-ty@kernel.dk>
Date:   Wed, 16 Feb 2022 19:48:09 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 15 Feb 2022 10:45:09 +0100, Christoph Hellwig wrote:
> this series adds a ->free_disk method to struct block_device_operation so that
> drivers can defer freeing their disk private data until the gendisk goes away
> and don't need to play games with the validity of ->private_data.
> 
> This also converts three simple drivers over as example, but eventually I
> imagine that all drivers with private data will use it.
> 
> [...]

Applied, thanks!

[1/5] block: add a ->free_disk method
      commit: 76792055c4c8b2472ca1ae48e0ddaf8497529f08
[2/5] memstick/ms_block: simplify refcounting
      commit: e2efa0796607efe60c708271be483c3a2b0128de
[3/5] memstick/mspro_block: fix handling of read-only devices
      commit: 6dab421bfe06a59bf8f212a72e34673e8acf2018
[4/5] memstick/mspro_block: simplify refcounting
      commit: 185ed423d1898ead071c18f6161959cd3cab2dde
[5/5] virtio_blk: simplify refcounting
      commit: 24b45e6c25173abcf8d5e82285212b47f2b0f86b

Best regards,
-- 
Jens Axboe


