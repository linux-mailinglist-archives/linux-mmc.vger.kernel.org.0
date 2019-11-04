Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8544EEF90
	for <lists+linux-mmc@lfdr.de>; Mon,  4 Nov 2019 23:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388825AbfKDWWI (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 4 Nov 2019 17:22:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36822 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388497AbfKDV5G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Nov 2019 16:57:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id c22so17748876wmd.1
        for <linux-mmc@vger.kernel.org>; Mon, 04 Nov 2019 13:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vzb+74WM5JBxulk7ceFJBCMvL3KG8eggJQ99GKu8LYI=;
        b=TjdRDyGWJjLwk47gu6GdG30XhS/m5zt9iHEk5mk+dtDBJ22ubVYUKI/UJd+F6m7EVO
         vPNXk8+9N9QBR6g2l8TOUKv6NOYx/QbVaQe6oJuJfhHIo8KQMGIFufupqGazOQ6685FG
         +9kHr6LovSMZymCXqHU2tA66ZOuPNjLeBNRnLIfU/f4BbmQSofUxdj8oiMimakCbdYoC
         Fdl4pRUuN4apEQWjmkfVssnkDlkC2SO8ftcZifGbR/C2pm5UhesS0weA0S6xd/nBOmbh
         WPt7JfPucKWevReELhVCifJl+crECkLJLgBmR6J4gv5affagJyzRw4R8t5oI7rKcXDw7
         +oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Vzb+74WM5JBxulk7ceFJBCMvL3KG8eggJQ99GKu8LYI=;
        b=qO5SHuXxlOD8X9euzhZ4rVA8c5dlnC/uRMkslhV5WeKSUVha2C67FZG/XNKLSEqWhp
         fJK/f/PQQ3eTg+FBGRUBv3cJYK2zU66iRURP1gOerMZ5yMThn6vD8nePLFOk7n8nZW12
         ewoxoxmadG7LfkKYaGYVLYUv2hLxB6X62mgjrX/xXdCRd833Ho5SrgM5+N4oH5QDyV2L
         Q+dr/RytLPDWRpTRRKc+cx7FwY1NhJTGeB+1LJngDPDYFxOM8kMe+v43EsBCJhrAD7W1
         SpwFFhOqg6hdYlbp2liowm6FnQFo6Y3O9zPKfb0GRrKxo+AJjo5IQhgCQ8+rGIIe0JbR
         XYRA==
X-Gm-Message-State: APjAAAVQrSdDK9DIA4+zcwdOXPl0wUH5mMTYBLYBj32f6oP2fBRrVtHy
        b2kNnI3pDB5z5g5NMFOWwNJ7LHh2
X-Google-Smtp-Source: APXvYqw7Pf4AhAy3ice7f1WOGH9WC7Xn1m0IyHwetAPCHV+LdhpZ3IDwfxjtncGECuiyGbFO7wraxA==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr1065736wmi.49.1572904624113;
        Mon, 04 Nov 2019 13:57:04 -0800 (PST)
Received: from [192.168.0.87] (HSI-KBW-109-192-080-035.hsi6.kabel-badenwuerttemberg.de. [109.192.80.35])
        by smtp.gmail.com with ESMTPSA id j63sm22157905wmj.46.2019.11.04.13.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 13:57:03 -0800 (PST)
Message-ID: <1572904622.28715.4.camel@googlemail.com>
Subject: Re: [PATCH 1/7] mmc-utils: interpret OPTIMAL_*_SIZE fields in extcsd
From:   Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To:     Chris Ball <chris@printf.net>
Cc:     James Nuss <jamesnuss@nanometrics.ca>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Avri Altman <Avri.Altman@wdc.com>
Date:   Mon, 04 Nov 2019 22:57:02 +0100
In-Reply-To: <SN6PR04MB49256CFEA5B525999B4AAD0BFCE00@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
         <4a016f761d388a989059467507f2bc948ba26c6c.1539103468.git.jamesnuss@nanometrics.ca>
         <SN6PR04MB49256CFEA5B525999B4AAD0BFCE00@SN6PR04MB4925.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2018-10-10 at 08:40 +0000, Avri Altman wrote:
> Looks fine.
> 
> Thanks,
> Avri
> 
> > eMMC 5.0 introduced OPTIMAL_READ_SIZE, OPTIMAL_WRITE_SIZE and
> > OPTIMAL
> > TRIM_UNIT_SIZE fields in the extcsd
> > 
> > Interpret these fields when reading out the extcsd with human-readable
> > results
> > 
> > Signed-off-by: James Nuss <jamesnuss@nanometrics.ca>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>

Hi Chris,

 are there any objections adding this and most of the other patches from
James?


  -- Christoph

