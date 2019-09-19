Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74290B8282
	for <lists+linux-mmc@lfdr.de>; Thu, 19 Sep 2019 22:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404583AbfISUeN (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 19 Sep 2019 16:34:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33836 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404596AbfISUeL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Sep 2019 16:34:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19so3448629lja.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Sep 2019 13:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6grpKTdDHfrbCxCmgX04tALzM2BaTcUONJxBFtS7/lc=;
        b=S3FWlmtalm02jQyJlhwBVUyRbo4LVnG04lBW17Zh/rM24U46hU9edZ8kfmA06+aF9P
         OCDHQuGS85M+r15ZS8w8p2AuuOaxpYBIEy7/K399Ohz2kO+HjNMiBSjs53Jhs8Tayd30
         RhVK3wUpwCIOZyzj1b4OwhDrWT6ry27EnqdWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6grpKTdDHfrbCxCmgX04tALzM2BaTcUONJxBFtS7/lc=;
        b=hEqNkuU8fgkj2avW2QBXyhYQ2Jfc7762ABtrgEB4mh5UyG33axmQ78GOBSHSgEkzoU
         aI17GqauHIWLgZezAWaxVH/qOZJuRTT7nk+6K9H3kOOeFvsSHIrpBz9lrnD+W6i5yWUW
         Q5RXwxlmz8XWTOD5Xr1I3u3KaYgJcMoA/eH9JUcc3SqOX8mfeaX8lXUQy/n1JWlvNDSr
         3Ueyts2EG67seGBT+hu3vvE9317jOsUOr4F+iw31NMbUrSY6kmUJyrbQH93DFKS43XOf
         mXzqqRc1cQq59mq5UAloNH8naBcZPt2FdtAV4LqY/65k54bK+7h/c3fWBOfvHXLN4JUR
         IXyQ==
X-Gm-Message-State: APjAAAX068Y4Ws6us7inSXLdh6qcPycOIm3Ag7wA3eVHFNIamid5WwPr
        y/SbsSgIj3xxIaxolab5Ou263gO+FaM=
X-Google-Smtp-Source: APXvYqyqk05lSOzwHmxxj1qJvHx4FEHoPhrRe7NwrC1BWdzv8F/9onht6AT3rRfpfEhbjoyKYUBAew==
X-Received: by 2002:a2e:9ac1:: with SMTP id p1mr213140ljj.179.1568925248646;
        Thu, 19 Sep 2019 13:34:08 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id a14sm1804389lfg.74.2019.09.19.13.34.07
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 13:34:07 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id q11so3326568lfc.11
        for <linux-mmc@vger.kernel.org>; Thu, 19 Sep 2019 13:34:07 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr6102537lfp.61.1568925247160;
 Thu, 19 Sep 2019 13:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190918152748.GA21241@infradead.org>
In-Reply-To: <20190918152748.GA21241@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Sep 2019 13:33:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXF63BKNJH=GtnnoJmXZHEnRwjgeu4foJQvFYYBm9HHA@mail.gmail.com>
Message-ID: <CAHk-=wjXF63BKNJH=GtnnoJmXZHEnRwjgeu4foJQvFYYBm9HHA@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping updates for 5.4
To:     Christoph Hellwig <hch@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>
Cc:     linux-mmc@vger.kernel.org,
        iommu <iommu@lists.linux-foundation.org>,
        xen-devel@lists.xenproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Sep 18, 2019 at 8:27 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> please pull the dma-mapping updates for 5.4.

Pulled.

> In addition to the usual Kconfig conflics where you just want to keep
> both edits there are a few more interesting merge issues this time:
>
>  - most importanly powerpc and microblaze add new callers of
>    dma_atomic_pool_init, while this tree marks the function static
>    and calls it from a common postcore_initcall().  The trivial
>    functions added in powerpc and microblaze adding the calls
>    need to be removed for the code to compile.  This will not show up
>    as a merge conflict and needs to be dealt with manually!

So I haven't gotten the powerpc or microblaze pull requests yet, so
I'm not able to fix that part up yet.

Intead, I'm cc'ing Michael Ellerman and Michal Simek to ask them to
remind me when they _do_ send those pull requests, since otherwise I
may well forget and miss it. Without an actual data conflict, and
since this won't show up in my build tests either, it would be very
easy for me to forget.

Micha[e]l, can you both please make sure to remind me?

             Linus
