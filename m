Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A696686FC2
	for <lists+linux-mmc@lfdr.de>; Fri,  9 Aug 2019 04:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbfHICnx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 8 Aug 2019 22:43:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35179 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbfHICnw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Aug 2019 22:43:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id l14so801151lje.2
        for <linux-mmc@vger.kernel.org>; Thu, 08 Aug 2019 19:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B7PSTqtyrxGq3f5vbI0J92yvqZIeqtiAC0/DJJCx3ik=;
        b=dF4T6l5HyeQRnVeG7Ws5HK6Mz4ngPZYXhK9ykZyukuXA42DbQEklk8elDgJERndyeY
         Px8Fb36iglK384sNn3oMRV/KwZwJflJ4ujwgx0DH5yplUDXOWzBqSryErg+ZAoaxApQD
         DWwiLkyDdaJnzIL73x+Wm36/oreZxBdXQUSKV1bINzIG9lOdYKpFJ00Kw+0EC8De421u
         79f9JsqMTPtb7TXjTuazIJK6TFqFan7e4TBjmxdVswLATxQLf/0iRVSwOafYLUFINrlu
         r/tHSjqIo9aqxH0SGkbpIY7ym9msnwapzMlxrNRgqj17Gb3GxDLuQwhIG1OzgtUuUfjd
         IL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B7PSTqtyrxGq3f5vbI0J92yvqZIeqtiAC0/DJJCx3ik=;
        b=KPx1R4rprGGiQuqWQFUbg2q6Xiaa8EGvLMTJJSYJvDcN/Sso1D8qilurDIXgG/wKxE
         SbkFs6JPwQKYGcmq8vwOhMaHPcT4+F3veC7Vd0WdHM0L0og40Ka8CWstZmiKxMNSkKBb
         DzAxknuZhjVzSpmfv06eBtVKD98S/96k+9Lel+siGQjriGEX0Z16gLBho4O+aYxyNSvd
         klF+XxIKOqYLskI3fpYtAuuGduAvfe4FYszRWbnXRmY6WDel+lkgSivLFu6OwoeDK0nv
         SdTNpGt3ujfdAIvt8iLgqUVwy/edvgSDHHG2a+OCOmACf6frswjFJhHx/zcn/xBFmsNK
         0A+g==
X-Gm-Message-State: APjAAAWNljrZdwjwk5j0mBpyVSjB4+/A+hD8/K9FAt+sHUwjnlEBRWR2
        WQq/ZL4aGSDHwyzh5W05A0h5B46LAppCz26+1a8=
X-Google-Smtp-Source: APXvYqzyKJoJ33r4+GJ+zG7BIXSALNzth6FEx4BUMaAcwLEDvFm3BKjt3H4pKtIPOJfmnqz30cjWGLJQMLv9LYSqAeQ=
X-Received: by 2002:a2e:96c3:: with SMTP id d3mr10077352ljj.68.1565318630576;
 Thu, 08 Aug 2019 19:43:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:4ac3:0:0:0:0:0 with HTTP; Thu, 8 Aug 2019 19:43:49 -0700 (PDT)
In-Reply-To: <20190808224809.GA41025@void.printf.net>
References: <CGME20190807091012epcas1p2d949c05b6dafb0a22f6babe13c5ae9c8@epcas1p2.samsung.com>
 <20190807091001.2957-1-js07.lee@samsung.com> <20190808224809.GA41025@void.printf.net>
From:   Jungseung Lee <js07.lee@gmail.com>
Date:   Fri, 9 Aug 2019 11:43:49 +0900
Message-ID: <CAPP0e=Ovv9KS4KP6v2g7hoTu50k-4Duvt2BgDYP5vUe4xfsXkQ@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: feature spec 5.0+, add secure removal type
 fileds to Extended CSD
To:     Chris Ball <chris@printf.net>
Cc:     Jungseung Lee <js07.lee@samsung.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 8/9/19, Chris Ball <chris@printf.net> wrote:
> Hi, thanks for the patch,
>
> On Wed, Aug 07, 2019 at 06:10:01PM +0900, Jungseung Lee wrote:
>> +				printf("by an overwriting the addressed locations"
>
> No need for "an", just "by overwriting the addressed locations".
>
>> +				printf("using a vendor defined\n");
>
> Maybe "using a vendor defined function"?
All the sentences came from JEDEC specification. (JESD84-B51A)
Is it more natural to change?
>
> Thanks,
>
> - Chris.
> --
> Chris Ball   <http://printf.net/>
>
Thanks,
