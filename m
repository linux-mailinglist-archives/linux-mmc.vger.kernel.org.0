Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DAE436855
	for <lists+linux-mmc@lfdr.de>; Thu, 21 Oct 2021 18:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhJUQwR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 21 Oct 2021 12:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhJUQwR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Oct 2021 12:52:17 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024FEC061348
        for <linux-mmc@vger.kernel.org>; Thu, 21 Oct 2021 09:50:00 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so1192150otb.1
        for <linux-mmc@vger.kernel.org>; Thu, 21 Oct 2021 09:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=H/Eozbq7KtLQv7I05PmFbNf/apdYsXdfHT73zybO8ZE=;
        b=WVreQnwbDkzUfWoXogfNSbxO7gQ5mEHdBCGow+FGfeTLO8lAO0KQ5uqcOslFmoLHrs
         2clYpPgdW10cKh1EId/lbwHWD5bXnZ4ftdhbtW9266w35OBGRf/06VDOkBeSjjSRBA7e
         2dXHzDSVLw9JVo4yngyMXyrNwx7QDTY4/94hxomTPJvSI58BrpiF7LQSD34rKKhLMWqt
         JjvP085MeYyMXzEOHbT7WF2P2vyXarBnsQsSd6gs8S5A6lqCRrXbntxu4gWyBSomycpq
         FE5K+hfoY0OGxR0+JVTC2hHYvrysUA6cCDnnApbvDJJfiV7kIqrcitBT6bX87Wz4gKTd
         g45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=H/Eozbq7KtLQv7I05PmFbNf/apdYsXdfHT73zybO8ZE=;
        b=fpkATD/jXD7lgoosSluJkNRFtvAr8KHoX3qIhNUikdKBdNvsnnxJbovj/nrtQvh3cf
         NfF5gGQiwNo2bRjVxW6CFHqOlSjp4LaeCue4Qr38ueXHi7AXbLE1qkOqdM0YWsr/X9ff
         gxs8TYl5E5M8IGvaySgDigTBpPDmgl6QdTKn0H30T9H/FA/86UsFu25Mrupud4PUBzXA
         s8GtWKtYeOVOeFI5Knw6tJBrY9mD4dA2BHG0ZtOIfun4iwULHqr9NVoZCwxGa9JiSRqL
         HNIVcEA7Bo4y9I2DxIuOceFLXRcpABpz3fTVriz04QtybrDEQtQFT8PdlYW/HmTw+V1O
         rAlQ==
X-Gm-Message-State: AOAM532kah0Jl5YLCKMuvsMfP7LmcZxbO4Cpn+YDiWZcI6DSW222rQyA
        lX+amDKN0uNx0Y7eJ4/C5ilP5QPQdCpgPw==
X-Google-Smtp-Source: ABdhPJw4fg+s6o/fbrAgM6IxFUri1B2riMoKLYLBK8KHXUcxmp3h8VPW/Swvw/MRzkp1OZUSWEvhAw==
X-Received: by 2002:a9d:3b8:: with SMTP id f53mr6001846otf.253.1634834999951;
        Thu, 21 Oct 2021 09:49:59 -0700 (PDT)
Received: from [127.0.1.1] ([2600:380:783a:c43c:af64:c142:4db7:63ac])
        by smtp.gmail.com with ESMTPSA id g29sm1179353oic.27.2021.10.21.09.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:49:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com
In-Reply-To: <20211018180453.40441-1-ebiggers@kernel.org>
References: <20211018180453.40441-1-ebiggers@kernel.org>
Subject: Re: [PATCH v6 0/4] blk-crypto cleanups
Message-Id: <163483499921.66288.14458324918559511031.b4-ty@kernel.dk>
Date:   Thu, 21 Oct 2021 10:49:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 18 Oct 2021 11:04:49 -0700, Eric Biggers wrote:
> This series renames struct blk_keyslot_manager to struct
> blk_crypto_profile, as it is misnamed; it doesn't always manage
> keyslots.  It's much more logical to think of it as the
> "blk-crypto profile" of a device, similar to blk_integrity_profile.
> 
> This series also improves the inline-encryption.rst documentation file,
> and cleans up blk-crypto-fallback a bit.
> 
> [...]

Applied, thanks!

[1/4] blk-crypto-fallback: properly prefix function and struct names
      commit: eebcafaebb17cb8fda671709fab5dd836bdc3a08
[2/4] blk-crypto: rename keyslot-manager files to blk-crypto-profile
      commit: 1e8d44bddf57f6d878e083f281a34d5c88feb7db
[3/4] blk-crypto: rename blk_keyslot_manager to blk_crypto_profile
      commit: cb77cb5abe1f4fae4a33b735606aae22f9eaa1c7
[4/4] blk-crypto: update inline encryption documentation
      commit: 8e9f666a6e66d3f882c094646d35536d2759103a

Best regards,
-- 
Jens Axboe


