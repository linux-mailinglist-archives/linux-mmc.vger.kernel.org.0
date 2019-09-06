Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4329AB4B6
	for <lists+linux-mmc@lfdr.de>; Fri,  6 Sep 2019 11:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbfIFJOj (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 6 Sep 2019 05:14:39 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:34196 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbfIFJOj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Sep 2019 05:14:39 -0400
Received: by mail-ed1-f51.google.com with SMTP id s49so5696707edb.1
        for <linux-mmc@vger.kernel.org>; Fri, 06 Sep 2019 02:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Y8XpBjHz7mb0N++Ul1x8wa+bfCjFml4ncflAiiwutQs=;
        b=JEN3yw9EPdQYCUXP9cOoce2KgijMvowL/mYBbxE0lt9bDgpPQlpPXB6sJBPtbqSSjX
         moVVjotdeMg8waTrUf785Q7CoV4eG6Va1BsX1iT4VXL6XhYVeSyKLzTgKgvj5j01y/LZ
         XN5nshYDd3OGYViIIKmJGom9KNTQJknkc1eEF8i9TwS1DZSwD6nbqnrqUm4cXjMFIpfb
         PK0VT2YFz3Pcj9zUjL0ymUQx2gKMB5zeR11qTKPHuyH/u8j8Z7WnzdCHtya4Ch+WDmbu
         aoNoI3UzPY7ibDv4PY4lCjERkuRVcp81VWSi5ygB3zxLcnMWtWV2a1MEb7BRMy2Ls3Xb
         zVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Y8XpBjHz7mb0N++Ul1x8wa+bfCjFml4ncflAiiwutQs=;
        b=IOX9oj9sYVtS6TsoglYyyREvFbFyZgywjvzDDqsY9izJzV4dZSo6MPtTm4uuXqNLoG
         bdGLS0QQQ/DMnoe6w41UH7bIVM4n8vkRnuwpIBBFw99FLbhGgTiryzFE+cm87kurP8Co
         xSz8k4okDsTKRP8xSQfQp2xSKYn2Gf/1fNlr/Mc7AdnnUTXUPXfRcon9JmwHkiRfiBrk
         FlP5Vs+D2ORa0WbIJ0TxsFd7YNEP3EpvPb7iZjPVR217R1vFvZXR4FgwgVTZ+Q7MIVVD
         TbYY9AiawdUOZS5CJyQQCerbyoQQit4zSeQ9WPNWbRIurf/1+xXkRIuQsa4lzG4nayCE
         3buw==
X-Gm-Message-State: APjAAAWZFtqjmU4rFPIgam7cgI6C/JSnmI4s6vik3uABMGCprG4ehRXy
        C2lkmyeT8r2/ANRDngoQ2CuvczFZYOkKd/t2QJqxi5fkcyc=
X-Google-Smtp-Source: APXvYqy/aHEVCkjFsT3eefhTJAM8TC4zJCE1uhplJ7sjM7UGEzhj2beFBezJ7r1/qETLKbQXtZSs7UNr/PzzrQpboww=
X-Received: by 2002:a17:906:1f14:: with SMTP id w20mr6297478ejj.248.1567761277692;
 Fri, 06 Sep 2019 02:14:37 -0700 (PDT)
MIME-Version: 1.0
From:   Belisko Marek <marek.belisko@gmail.com>
Date:   Fri, 6 Sep 2019 11:14:26 +0200
Message-ID: <CAAfyv37SXnNz07a4tKkLiY9CtD72YjBJmKhHcQq=QiM2608-fA@mail.gmail.com>
Subject: slow emmc speed 4.12 am437x
To:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

I'm trying to get some insights about how to debug emmc speed issue.
We're using board with am437x CPU using mainline 4.12 kernel (added
only devicetree for our custom board). eMMC is 8bit connect (using
sandisk SDINBDG4-8G-I1 chip).

Issue is that when copying data from SD card to eMMC we get throughput
only ~300kB/s (it should be bit higher IIRC). I'm just looking for
some advice what to check and how to find out where issue can be
(still unsure if SW or HW). Thanks a lot.

BR,

marek
