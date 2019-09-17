Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F71FB4F91
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Sep 2019 15:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfIQNnm (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Sep 2019 09:43:42 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:41132 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfIQNnm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Sep 2019 09:43:42 -0400
Received: by mail-lf1-f42.google.com with SMTP id r2so2909973lfn.8
        for <linux-mmc@vger.kernel.org>; Tue, 17 Sep 2019 06:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jaR67NcODPqTTItBcNnTcwyC7On88LzFc42SdZKoDiU=;
        b=RjHUlGcXynYUSVNZeSKoCWycjgHv+rcUY1DlquvB9SJ4x7WWa9zsHN/46RIhTycyHD
         tw/PDto5Q7j0zluQRHTxvvtl5WIfQ7LS34L+C3RXspayzieZUGVSccAIcZXl9a/ZhqOL
         AqiOUU1vxy4rIgiwqbr1SeW1CnRc46sVDkQgJg85EAOrWK3C1yd8NGIPPQp0MeVVQI87
         1kC5Un1vtJyXhOO1LVvZYYyT4MxFWQSKbp226/U4WepXT7hV8bpNbGpeG3p+HDIDrUQC
         NatCgNbL+S180EAwBcwC5mSjuUKo0ahc/fMobvcKIxqz4nSNydMKtnu9io80EeWhTxc0
         27vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jaR67NcODPqTTItBcNnTcwyC7On88LzFc42SdZKoDiU=;
        b=HxkTlk4Xshw9sI/x3lvgykM+Qv3O8Is1XJCDIWUZvN0Aakm+UZRqUKrEyHCCeBiiOj
         c7KbQNiIowFyCJJQPWGOrHEfyD6Lm4x/Mr6rRctXF9UNJE4HJ9y4KXWYcw3IyInxwuzI
         cJCBLSt32E+2zd+GGgEqRxB/KbM8GIFsi1r0px2jcrb4X9p2x+kJnlDejGiXXgIVrYFQ
         ZdAIbfn72bxCEMefEUHsTVXGznt2B+ga+LztDF9GM1sqN07v4euFfg24hEycX8uB7/I5
         TrxXxt9QYxTJBUMrAmYjQLBZ84mlud/DvZrE58CrVrL7JzH34zdtjf6jvuVkt6OqTFi/
         cqdg==
X-Gm-Message-State: APjAAAWanLDfKJsd22JtGWAK6NAQxoRRIVxUxkVNOPmNnGLr8Ao7bunN
        BFz2aloDN0Bp+8exWWET+a7FWLGLjq1P7gY/buM=
X-Google-Smtp-Source: APXvYqyX0yuxcPRS3QnpKfcwgYilUe3ddgxBIGAjmMV1HE7vpPKedQFLqoaUxblLKGGdoSo00h2QzObroYpBUtJNtUY=
X-Received: by 2002:ac2:5091:: with SMTP id f17mr2182698lfm.107.1568727820058;
 Tue, 17 Sep 2019 06:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190916171509.GG25745@shell.armlinux.org.uk> <b19a0640-5d71-a005-eb0f-c6840f181e5d@free.fr>
 <20190917081931.GI25745@shell.armlinux.org.uk> <20190917104200.GJ25745@shell.armlinux.org.uk>
 <20190917111631.GL25745@shell.armlinux.org.uk> <20190917114210.GM25745@shell.armlinux.org.uk>
 <20190917123326.GN25745@shell.armlinux.org.uk> <20190917130759.GO25745@shell.armlinux.org.uk>
 <CAOMZO5DXv8g5qTGdvobDdLWim+tW=vK4+K=P-VqJK23KERMhJw@mail.gmail.com> <20190917133317.GQ25745@shell.armlinux.org.uk>
In-Reply-To: <20190917133317.GQ25745@shell.armlinux.org.uk>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 17 Sep 2019 10:43:35 -0300
Message-ID: <CAOMZO5DS_1Uc9TMc29e+8tCg-srvMjf3uth_9P3cnro6det+7A@mail.gmail.com>
Subject: Re: [REGRESSION] sdhci no longer detects SD cards on LX2160A
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        dann frazier <dann.frazier@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 17, 2019 at 10:33 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:

> That attempts to set bit 12 of the host control register 2 (0x3e).
> The LX2160A documentation states that bit 28 of 0x3c (they're 32-bit
> wide registers there) is "reserved".
>
> So, you're asking for a documented reserved bit to be set...

Correct, v4 is not supported here indeed.

From the LX2160 doc:
"Conforms to the SD Host Controller Standard Specification version 3.0"
